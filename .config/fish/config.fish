if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Source files in fish directory
for file in ~/.config/fish/.{functions*,exports*,aliases*}
  if test -r $file
    source "$file"
  end
end
