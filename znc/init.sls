{% set bucket = salt['pillar.get']('secrets:bucket') %}

znc:
  pkg:
    - installed
  user.present:
    - system: True
    - home: /var/lib/znc
    - shell: /usr/sbin/nologin
    - gid_from_name: True
  service.running:
    - require:
      - file: znc-config
      - file: adminlog-config
      - file: /etc/init/znc.conf

/etc/init/znc.conf:
  file.managed:
    - source: salt://znc/znc-init.conf
    - user: root
    - group: root
    - mode: 644

/var/run/znc:
  file.directory:
    - user: znc
    - group: znc
    - mode: 755

znc-subdirs:
  file.directory:
    - names:
      - /var/lib/znc/configs
      - /var/lib/znc/modules
      - /var/lib/znc/moddata
    - user: znc
    - group: znc
    - mode: 750
    - require:
      - user: znc

znc-config:
  file.managed:
    - name: /var/lib/znc/configs/znc.conf
    - template: jinja
    - source: salt://znc/znc.conf.jinja
    - replace: False
    - user: znc
    - group: znc
    - mode: 640
    - require:
      - file: znc-subdirs

adminlog-dir:
  file.directory:
    - name: /var/lib/znc/moddata/adminlog
    - user: znc
    - group: znc
    - mode: 750
    - require:
       - file: znc-subdirs

adminlog-config:
  file.managed:
    - name: /var/lib/znc/moddata/adminlog/.registry
    - source: salt://znc/adminlog-registry
    - user: znc
    - group: znc
    - mode: 640
    - require:
      - file: adminlog-dir

znc-pem:
  file.managed:
    - name: /var/lib/znc/znc.pem
    - source: salt://znc/znc.pem
    - replace: False
    - user: znc
    - group: znc
    - mode: 640
    - require:
      - file: znc-subdirs
    - require_in:
      - service: znc
