function fuzzy_ssh
  set -l query (commandline)
  awk '
    tolower($1)=="host" {
      for(i=2;i<=NF; i++) {
        if ($i !~ "[*?]") {
          print $i
        }
      }
    }
  ' ~/.ssh/config ~/.ssh/ssh_config.d/*.conf | sed "s/\r//" | sort | fzf --prompt "SSH> " --query $query | read -l node

  if test -n "$node"
    commandline -r "ssh $node"
  end
end
