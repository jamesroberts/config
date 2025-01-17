if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Source files in fish directory
for file in ~/.config/fish/.{functions*,exports*,aliases*}
  if test -r $file
    source "$file"
  end
end



function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s @ %s%s%s > ' $USER \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
    # Show complete paths, do not shorten directory components
    set -U fish_prompt_pwd_dir_length 0
end
