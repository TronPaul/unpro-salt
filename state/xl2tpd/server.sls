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

chap_secrets_permissions:
  file.managed:
    - name: /etc/ppp/chap-secrets
    - create: False
    - replace: False
    - user: root
    - group: root
    - mode: '0600'
    - require:
      - pkg: xl2tpd
    - require_in:
      - service: xl2tpd

chap_secrets:
  file.exists:
    - name: /etc/ppp/chap-secrets
    - require:
      - pkg: xl2tpd
    - require_in:
      - service: xl2tpd
