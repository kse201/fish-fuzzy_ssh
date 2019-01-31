function peco_ssh
  set -l query (commandline)
  if test -n $query
    set peco_flags --query "$query"
  end

  awk '
    tolower($1)=="host" {
      for(i=2;i<=NF; i++) {
        if ($i !~ "[*?]") {
          print $i
        }
      }
    }
  ' ~/.ssh/config | sort | peco --prompt "SSH>" $peco_flags | read -l node

  if test -n "$node"
    commandline -r "ssh $node"
  end
end
