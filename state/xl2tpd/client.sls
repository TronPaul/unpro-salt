include:
  - .common

/etc/ppp/ip-up.d/50teamunpro:
  file.managed:
    - source: salt://xl2tpd/50teamunpro
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: xl2tpd
    - require_in:
      - service: xl2tpd
    - watch_in:
      - service: xl2tpd

/etc/ppp/options.xl2tpd.client:
  file.managed:
    - source: salt://xl2tpd/options.xl2tpd.client
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - replace: False
    - require:
      - pkg: xl2tpd
    - require_in:
      - service: xl2tpd
    - watch_in:
      - service: xl2tpd
