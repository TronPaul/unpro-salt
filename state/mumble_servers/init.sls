include:
  - .package

{% set db_path = "/var/lib/mumble-server" %}
{% set bucket = "teamunpro-backup" %}
{% set backup_path = "mumble" %}

{% for name, mumble_server in pillar.get('mumble_servers', {}).items() %}
{%- if mumble_server == None -%}
{%- set mumble_server = {} -%}
{%- endif -%}

mumble-server_{{name}}:
  service:
    - running
    - watch:
      - pkg: mumble-server
      - file: /etc/init.d/mumble-server_{{name}}
      - file: /etc/mumble-server/{{name}}.ini
    - require:
      - pkg: mumble-server
      - file: /etc/mumble-server/{{name}}.ini
      - file: /etc/init.d/mumble-server_{{name}}
      - file: /etc/default/mumble-server_{{name}}

/etc/logrotate.d/mumble-server_{{name}}:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://mumble_servers/mumble-server.logrotate.jinja
    - context:
      server_name: '{{name}}'

/etc/mumble-server/{{name}}.ini:
  file.managed:
    - template: jinja
    - user: mumble-server
    - group: root
    - mode: 640
    - source: salt://mumble_servers/mumble-server.ini.jinja
    - context:
      server_name: '{{name}}'
      mumble_server:
        {% for key, value in mumble_server.items() -%}
        {{key}}: {{value}}
        {%- endfor %}

/etc/init.d/mumble-server_{{name}}:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 755
    - source: salt://mumble_servers/mumble-server.init.d.jinja
    - context:
      server_name: '{{name}}'

/etc/default/mumble-server_{{name}}:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://mumble_servers/mumble-server.default

{% if 'ec2' in grains %}
{% set db_file = name + ".sqlite" %}
{{db_path}}/{{db_file}}:
  file.managed:
    - user: mumble-server
    - group: mumble-server
    - mode: 600
    - replace: False
    - source: s3://{{bucket}}/{{backup_path}}/{{db_file}}
    - source_hash: s3://{{bucket}}/{{backup_path}}/{{db_file}}.sha256
    - watch_in:
      - service: mumble-server_{{name}}
    - require_in:
      - service: mumble-server_{{name}}
      
backup_mumble_database:
  cron.present:
    - name: /usr/local/bin/backup_mumble_database.sh {{name}}
    - identifier: backup_{{name}}_mumble_database
    - user: root
    - minute: random
    - hour: 6
    - requires:
      - file: /usr/local/bin/backup_mumble_database.sh
{% endif %}
{% endfor %}

{% if 'ec2' in grains %}
/usr/local/bin/backup_mumble_database.sh:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 755
    - source: salt://mumble_server/backup_mumble_database.sh.jinja
    - context:
      bucket: {{bucket}}
      backup_path: {{backup_path}}
      db_path: {{db_path}}
{% endif %}
