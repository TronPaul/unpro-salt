/etc/xl2tpd/xl2tpd.conf:
  file.managed:
    - source: salt://xl2tpd/xl2tpd.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - require:
      - pkg: xl2tpd

/etc/init.d/xl2tpd:
  file.managed:
    - source: salt://xl2tpd/xl2tpd
    - user: root
    - group: root
    - mode: 755

xl2tpd:
  pkg:
    - installed
  service.running:
    - enable: True
    - require:
      - pkg: xl2tpd
      - file: /etc/xl2tpd/xl2tpd.conf
      - file: /etc/init.d/xl2tpd
