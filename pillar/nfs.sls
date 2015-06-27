nfs:
  server:
    exports:
      /export: 192.168.1.0/24(ro,fsid=root,no_subtree_check)
      /export/media: 192.168.1.0/24(ro,nohide,no_subtree_check)
      /export/deluge: 192.168.1.0/24(ro,nohide,no_subtree_check)
  mount:
    nasus:
      - mount_point: /srv/nasus
      - location: nasus:/

unpro-nfs:
  server:
    binds:
      - name: media
        path: /srv/media
      - name: deluge
        path: /srv/deluge
