include:
  - .common

/etc/init.d/deluged:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://deluge/deluged.init.d

/etc/default/deluged:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://deluge/deluge-all.default

/var/log/deluge:
  file.directory:
    - user: deluge
    - group: deluge
    - mode: 755
    - require:
      - user: deluge

deluged:
  pkg.installed:
    - require:
      - pkgrepo: deluge-ppa
  service.running:
    - require:
      - file: /var/log/deluge
      - file: /etc/init.d/deluged
      - file: /etc/default/deluged
      - file: deluged-set-downloading
      - file: deluged-set-completed
      - file: deluged-set-torrents
      - file: deluged-set-move-completed
      - file: deluged-set-autoadd
    - watch:
      - file: deluged-set-downloading
      - file: deluged-set-completed
      - file: deluged-set-torrents
      - file: deluged-set-move-completed
      - file: deluged-set-autoadd
  cmd.run:
    - name: /etc/init.d/deluged start && sleep .5 && /etc/init.d/deluged stop
    - unless: test -f /home/deluge/.config/deluge/core.conf
    - require:
      - file: /var/log/deluge
      - file: /etc/init.d/deluged
      - file: /etc/default/deluged
      - pkg: deluged
      - user: deluge

deluged-set-downloading:
  file.replace:
    - name: /home/deluge/.config/deluge/core.conf
    - pattern: '"download_location": "[^"]*?",'
    - repl: '"download_location": "/srv/deluge/downloading",'
    - require:
      - cmd: deluged

deluged-set-completed:
  file.replace:
    - name: /home/deluge/.config/deluge/core.conf
    - pattern: '"move_completed_path": "[^"]*?",'
    - repl: '"move_completed_path": "/srv/deluge/completed",'
    - require:
      - cmd: deluged
  
deluged-set-torrents:
  file.replace:
    - name: /home/deluge/.config/deluge/core.conf
    - pattern: '"torrentfiles_location": "[^"]*?",'
    - repl: '"torrentfiles_location": "/srv/deluge/torrents",'
    - require:
      - cmd: deluged
  
deluged-set-move-completed:
  file.replace:
    - name: /home/deluge/.config/deluge/core.conf
    - pattern: '"move_completed": [^,]*?,'
    - repl: '"move_completed": true,'
    - require:
      - cmd: deluged
  
deluged-set-autoadd:
  file.replace:
    - name: /home/deluge/.config/deluge/core.conf
    - pattern: '"autoadd_location": "[^"]*?",'
    - repl: '"autoadd_location": "/srv/deluge/queue",'
    - require:
      - cmd: deluged
