for s in `tmux list-sessions -F '#{session_name}'` ; do
  echo -e "\ntmux session name: $s\n--------------------"
  for p in `tmux list-panes -s -F '#{pane_pid}' -t "$s"` ; do
    pstree -p -a -A $p
  done
done
