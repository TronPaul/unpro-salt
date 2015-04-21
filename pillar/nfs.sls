nfs:
  server:
    binds:
      - name: media
        path: /srv/media
      - name: media
        path: /srv/deluge
    exports:
      /export: 192.168.1.0/24(ro,fsid=root,no_subtree_check)
      /export/media: 192.168.1.0/24(ro,nohide,no_subtree_check)
      /export/deluge: 192.168.1.0/24(ro,nohide,no_subtree_check)
  client:
    mounts:
      - mount_point: /srv/nasus
      - url: nasus:/
