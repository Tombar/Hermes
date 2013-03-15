function cd --description "Change working directory"
  # Source a .rvmrc file in a directory after changing to it, if it exists.
  # To disable this fature, set rvm_project_rvmrc=0 in $HOME/.rvmrc

  builtin cd $argv
  if test "$rvm_project_rvmrc" != 0
    set -l cwd $PWD
    if test -s ".rvmrc"
        rvm rvmrc load
    else
        set -x rvm_bin_path 
        set -x rvm_env_string
        set -x rvm_path 
        set cwd (dirname "$cwd")
    end
    set -e cwd
  end
end


