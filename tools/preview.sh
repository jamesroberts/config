#!/usr/bin/env bash
# https://github.com/junegunn/fzf.vim/blob/master/bin/preview.sh

REVERSE="\x1b[7m"
RESET="\x1b[m"

if [[ $# -lt 1 ]]; then
  echo "usage: $0 [--tag] FILENAME[:LINENO][:IGNORED]"
  exit 1
fi

if [[ $1 = --tag ]]; then
  shift
  "$(dirname "${BASH_SOURCE[0]}")/tagpreview.sh" "$@"
  exit $?
fi

# Ignore if an empty path is given
[[ -z $1 ]] && exit

IFS=':' read -r -a INPUT <<< "$1"
FILE=${INPUT[0]}
CENTER=${INPUT[1]}

if [[ "$1" =~ ^[A-Za-z]:\\ ]]; then
  FILE=$FILE:${INPUT[1]}
  CENTER=${INPUT[2]}
fi

if [[ -n "$CENTER" && ! "$CENTER" =~ ^[0-9] ]]; then
  exit 1
fi
CENTER=${CENTER/[^0-9]*/}

# MS Win support
if [[ "$FILE" =~ '\' ]]; then
  if [ -z "$MSWINHOME" ]; then
    MSWINHOME="$HOMEDRIVE$HOMEPATH"
  fi
  if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    MSWINHOME="${MSWINHOME//\\/\\\\}"
    FILE="${FILE/#\~\\/$MSWINHOME\\}"
    FILE=$(wslpath -u "$FILE")
  elif [ -n "$MSWINHOME" ]; then
    FILE="${FILE/#\~\\/$MSWINHOME\\}"
  fi
fi

FILE="${FILE/#\~\//$HOME/}"
if [ ! -r "$FILE" ]; then
  echo "File not found ${FILE}"
  exit 1
fi

if [ -z "$CENTER" ]; then
  CENTER=0
fi

# Sometimes bat is installed as batcat.
if command -v batcat > /dev/null; then
  BATNAME="batcat"
elif command -v bat > /dev/null; then
  BATNAME="bat"
fi

OFFSET=$(($LINES / 2))
LOWER_RANGE=$(($CENTER-$OFFSET))
UPPER_RANGE=$(($CENTER+$OFFSET))

echo "zxzx $OFFSET, $LOWER_RANGE, $UPPER_RANGE"

if [ "$LOWER_RANGE" -lt 0 ]; then
    LOWER_RANGE=0
fi
if [ "$UPPER_RANGE" -lt $LINES ]; then
    UPPER_RANGE=$LINES
fi

if [ -z "$FZF_PREVIEW_COMMAND" ] && [ "${BATNAME:+x}" ]; then
    ${BATNAME} --style="${BAT_STYLE:-numbers}" --color=always --pager=never --line-range $LOWER_RANGE:$UPPER_RANGE \
      --highlight-line=$CENTER -- "$FILE"
  exit $?
fi

FILE_LENGTH=${#FILE}
MIME=$(file --dereference --mime -- "$FILE")
if [[ "${MIME:FILE_LENGTH}" =~ binary ]]; then
  echo "$MIME"
  exit 0
fi

DEFAULT_COMMAND="highlight -O ansi -l {} || coderay {} || rougify {} || cat {}"
CMD=${FZF_PREVIEW_COMMAND:-$DEFAULT_COMMAND}
CMD=${CMD//{\}/$(printf %q "$FILE")}

eval "$CMD" 2> /dev/null | awk "{ \
    if (NR == $CENTER) \
        { gsub(/\x1b[[0-9;]*m/, \"&$REVERSE\"); printf(\"$REVERSE%s\n$RESET\", \$0); } \
    else printf(\"$RESET%s\n\", \$0); \
    }"
