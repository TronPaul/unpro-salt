include:
  - .common

/etc/ppp/options.xl2tpd.client:
  file.managed:
    - source: salt://xl2tpd/options.xl2tpd.client
    - user: root
    - group: root
    - require:
      - pkg: xl2tpd
    - require_in:
      - service: xl2tpd
