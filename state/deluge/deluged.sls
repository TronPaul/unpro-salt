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
    - unless: test -f /home/deluge/.config/deluge/core.conf
    - require:
      - file: /etc/init.d/deluged
      - file: /etc/default/deluged
      - pkg: deluged
      - user: deluge
