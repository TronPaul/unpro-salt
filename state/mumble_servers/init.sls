include:
  - .package

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
{% set db_name = name + ".sqlite" %}
{% set db_path = "/var/lib/mumble-servers/" + db_name %}
{% set bucket = "teamunpro-backup" %}
{% set backup_path = "mumble/" + db_name %}
/var/lib/mumble-servers/{{name}}.sqlite:
  file.managed:
    - user: mumble-server
    - group: mumble-server
    - mode: 600
    - replace: False
    - source: s3://{{bucket}}/{{backup_path}}
    - source_hash: s3://{{bucket}}/{{backup_path}}.sha256
    - watch_in:
      - service: mumble-server_{{name}}
    - require_in:
      - service: mumble-server_{{name}}

backup_mumble_database:
  cron.present:
    - name: salt-call s3.put {{bucket}} {{backup_path}} local_file={{db_path}}
    - identifier: backup_mumble_database
    - user: root
    - minute: random
    - hour: 6
{% endif %}
{% endfor %}
