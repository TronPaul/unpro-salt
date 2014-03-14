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
  service:
    - running
  cmd.run:
    - name: /etc/init.d/deluge-web start && sleep .5 && /etc/init.d/deluge-web stop
    - unless: test -f /home/deluge/.config/deluge/web.conf
    - require:
      - file: /etc/init.d/deluge-web
      - file: /etc/default/deluge-web
      - pkg: deluge-web
      - user: deluge

#deluge-web-stopped:
#  service:
#    - name: deluge-web
#    - dead