nfs:
  subnet: 192.168.1.0/24
  root_options:
    - ro
    - fsid=root
    - no_subtree_check
  mounts:
    media:
      source: /srv/media
      options:
        - ro
        - no_subtree_check
        - nohide
    deluge:
      source: /srv/deluge
      options:
        - ro
        - no_subtree_check
        - nohide
