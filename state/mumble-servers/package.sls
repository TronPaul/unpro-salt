mumble-server:
  pkg:
    - installed
  cmd.run:
    - name: service mumble-server stop
    - prereq:
      - file: /etc/init.d/mumble-server

/etc/mumble-server.ini:
  file.absent:
    - require:
      - pkg: mumble-server

/etc/logrotate.d/mumble-server:
  file.absent:
    - require:
      - pkg: mumble-server
  

/etc/default/mumble-server:
  file.absent:
    - require:
      - pkg: mumble-server

/etc/init.d/mumble-server:
  file.absent:
    - require:
      - pkg: mumble-server

/etc/mumble-server:
  file.directory:
    - user: mumble-server
    - group: root
