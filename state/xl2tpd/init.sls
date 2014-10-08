/etc/xl2tpd/xl2tpd.conf:
  file.managed:
    - source: salt://xl2tpd/xl2tpd.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - require:
      - pkg: xl2tpd

/etc/ppp/options.xl2tpd:
  file.managed:
    - source: salt://xl2tpd/options.xl2tpd.jinja
    - template: jinja
    - user: root
    - group: root
    - require:
      - pkg: xl2tpd

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

chap_secrets:
  file.exists:
    - name: /etc/ppp/chap-secrets
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
      - file: /etc/ppp/options.xl2tpd
      - file: /etc/xl2tpd/xl2tpd.conf
      - file: chap_secrets
      - file: chap_secrets_permissions
      - file: /etc/init.d/xl2tpd
