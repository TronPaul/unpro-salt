nfs:
  subnet: 192.168.1.0/24
  root_options:
    - r
    - fsid=root
    - no_subtree_check
  mounts:
    media:
      source: /srv/media
      options:
        - r
        - no_subtree_check
        - nohide
