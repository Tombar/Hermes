if status --is-login

  for p in /usr/local/bin /usr/local/sbin /opt/local/bin ~/.hermes/hermes/bin /usr/local/sbin 
    if test -d $p
      set -x PATH $p $PATH
    end
  end

end

. functions/*.fish

set fish_greeting ""
set -x CLICOLOR 1
set -u EDITOR /usr/local/bin/vim
set -u NODE_PATH /usr/local/lib/node

autojump   > /dev/null

function rehash
  . ~/.config/fish/config.fish
end

function flush
  dscacheutil -flushcache
end

function q
  ssh ssh.abc5.crvt.net -p 64088 -A
end

function wtime 
  curl -o /dev/null -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total} \n" -s $argv
end

function repo 
  curl -k -X POST --user tombar:nelson1  "https://api.bitbucket.org/1.0/repositories" -d "name=$argv" -d "is_private=true" -d "owner=crovat" > /dev/null
  echo "Repo creado > git clone git@bitbucket.org:crovat/$argv.git"
end

function fish_prompt -d "Write out the prompt"
  set -l last_status $status

  # Print last fg task exit status
  switch $last_status
    case 0
        # do nothing
    case '*'
        printf '%sExit code %s for last command \n' (set_color red) (echo $last_status)
  end

  printf '%s%s@%s:' (set_color cyan) (whoami) (hostname)
  # color writeable dirs green, read-only dirs red
  if test -w "."
    printf '%s%s' (set_color brown) (pwd)
  else
    printf '%s%s' (set_color red) (pwd)
  end

  # Print git branch
  if test -d ".git"
    printf ' %s' (parse_git_branch)
  end

  # Print RVM info
  printf ' %s%s ' (set_color green) (~/.rvm/bin/rvm-prompt v g)

  # Separator and reset
  printf '%s$ %s' (set_color brown) (set_color normal)

end
