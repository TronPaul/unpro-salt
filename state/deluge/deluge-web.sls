include:
  - .common

/etc/init.d/deluge-web:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://deluge/deluge-web.init.d

/etc/default/deluge-web:
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
  service.running:
    - enable: True
    - require:
      - file: /etc/default/deluge-web
      - file: /etc/init.d/deluge-web
