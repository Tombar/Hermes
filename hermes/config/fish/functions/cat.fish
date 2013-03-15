function cat --description "Cat with colorized output when available"
  # if the file is readable by pygmentize, use it. Falls back to cat.
  pygmentize $argv 2> /dev/null; or /bin/cat $argv
end
