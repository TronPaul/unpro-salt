deluge-ppa:
  pkgrepo.managed:
    - humanname: Deluge PPA
    - name: deb http://ppa.launchpad.net/deluge-team/ppa/ubuntu precise main
    - file: /etc/apt/sources.list.d/deluge.list
    - keyid: 249AD24C
    - keyserver: keyserver.ubuntu.com

deluge:
  user.present:
    - system: True

/etc/init.d/deluge-web:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://deluge/deluge-web.init.d

/etc/init.d/deluged:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://deluge/deluged.init.d

/etc/default/deluge-web:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://deluge/deluge-all.default

/etc/default/deluged:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://deluge/deluge-all.default

deluge-web:
  pkg:
    - installed
    - require:
      - pkgrepo: deluge-ppa
  service:
    - running
    - watch:
      - file: deluge-web-modify-config
  cmd.run:
    - name: /etc/init.d/deluge-web start && sleep .5 && /etc/init.d/deluge-web stop
    - creates: /home/deluge/.config/deluge/web.conf
    - require:
      - file: /etc/init.d/deluge-web
      - file: /etc/default/deluge-web
      - pkg: deluge-web
      - user: deluge

deluged:
  pkg:
    - installed
    - require:
      - pkgrepo: deluge-ppa
  service:
    - running
    - require:
      - cmd: deluged
  cmd.run:
    - name: /etc/init.d/deluged start && sleep .5 && /etc/init.d/deluged stop
    - creates: /home/deluge/.config/deluge/core.conf
    - require:
      - file: /etc/init.d/deluge-web
      - file: /etc/default/deluge-web
      - pkg: deluge-web
      - user: deluge

deluge-web-modify-config:
  file.replace:
    - name: /home/deluge/.config/deluge/web.conf
    - pattern: '"https": false,'
    - repl: '"https": true,'
    - require:
      - cmd: deluge-web
