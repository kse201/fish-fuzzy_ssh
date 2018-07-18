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
  ' ~/.ssh/config | sort | peco --prompt "SSH>" $peco_flags | read -l hostname

  if test -n "$hostname"
    commandline -r "ssh $hostname"
  end
end
