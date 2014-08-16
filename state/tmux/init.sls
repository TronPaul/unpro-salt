tmux:
  pkg.installed

tmux-conf:
  file.managed:
    - name: /etc/tmux.conf
    - source: salt://tmux/tmux.conf
