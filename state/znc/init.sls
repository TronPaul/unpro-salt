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
{% if bucket %}
    - source: s3://znc/configs/znc.conf
    - source_hash: s3://znc/configs/znc.conf.sha256
{% else %}
    - template: jinja
    - source: salt://znc/znc.conf.jinja
{% endif %}
    - replace: False
    - user: znc
    - group: znc
    - mode: 640
    - require:
      - file: znc-subdirs

{% if bucket %}
backup-znc-config:
  cron.present:
    - name: /usrlocal/bin/backup-znc-config
    - identifier: backup-znc-config
    - user: root
    - minute: random
    - hour: 6
    - require:
      - file: /usr/local/bin/backup-znc-config

/usr/local/bin/backup-znc-config:
  file.managed:
    - template: jinja
    - source: salt://znc/backup-znc-config.jinja
    - user: root
    - group: root
    - mode: 755
{% endif %}

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

{% if bucket %}
znc-pem:
  file.managed:
    - name: /var/lib/znc/znc.pem
    - source: s3://{{bucket}}/znc/znc.pem
    - source_hash: s3://{{bucket}}/znc/znc.pem.sha256
    - replace: False
    - user: znc
    - group: znc
    - mode: 640
    - require:
      - file: znc-subdirs
    - require_in:
      - service: znc
{% else %}
znc-pem:
  cmd.run:
    - name: znc -d /var/lib/znc -p
    - user: znc
    - creates: /var/lib/znc/znc.pem
    - require:
      - file: znc-subdirs
  file.managed:
    - name: /var/lib/znc/znc.pem
    - create: False
    - replace: False
    - user: znc
    - group: znc
    - mode: 640
    - require:
      - file: znc-subdirs
    - require_in:
      - service: znc
{% endif %}
