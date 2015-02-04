nfs:
  root:
    subnets:
      192.168.1.0/24:
        options:
          - ro
          - fsid=root
          - no_subtree_check
      10.0.254.0/24:
        options:
          - ro
          - fsid=root
          - no_subtree_check
  mounts:
    media:
      source: /srv/media
      subnets:
        192.168.1.0/24:
          options:
            - ro
            - no_subtree_check
            - nohide
        10.0.254.0/24:
          options:
            - ro
            - no_subtree_check
            - nohide
    deluge:
      source: /srv/deluge
      subnets:
        192.168.1.0/24:
          options:
            - ro
            - no_subtree_check
            - nohide
        10.0.254.0/24:
          options:
            - ro
            - no_subtree_check
            - nohide
