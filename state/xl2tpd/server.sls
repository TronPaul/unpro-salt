include:
  - .common

/etc/ppp/options.xl2tpd:
  file.managed:
    - source: salt://xl2tpd/options.xl2tpd
    - user: root
    - group: root
    - require:
      - pkg: xl2tpd
    - require_in:
      - service: xl2tpd
    - watch_in:
      - service: xl2tpd

/etc/ppp/chap-secrets:
  file.managed:
    - source: salt://xl2tpd/chap-secrets
    - template: jinja
    - replace: False
    - user: root
    - group: root
    - mode: '0600'
    - require:
      - pkg: xl2tpd
    - require_in:
      - service: xl2tpd
