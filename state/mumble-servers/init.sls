include:
  - mumble-servers.package

{% for name, mumble_server in pillar.get('mumble-servers', {}).items() %}
{%- if mumble_server == None -%}
{%- set mumble_server = {} -%}
{%- endif -%}

mumble-server_{{ name }}:
  service:
    - running
    - watch:
      - pkg: mumble-server
      - file: /etc/init.d/mumble-server_{{ name }}
      - file: /etc/mumble-server/{{ name }}.ini
    - require:
      - pkg: mumble-server
      - file: /etc/mumble-server/{{ name }}.ini
      - file: /etc/init.d/mumble-server_{{ name }}
      - file: /etc/default/mumble-server_{{ name }}

/etc/mumble-server/{{ name }}.ini:
  file.managed:
    - template: jinja
    - user: mumble-server
    - group: root
    - mode: 640
    - source: salt://mumble-servers/mumble-server.ini.jinja
    - context:
      server_name: '{{ name }}'
      mumble_server:
        {% for key, value in mumble_server.items() -%}
        {{ key }}: {{ value }}
        {%- endfor %}

/etc/init.d/mumble-server_{{ name }}:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 755
    - source: salt://mumble-servers/mumble-server.init.d.jinja
    - context:
      server_name: '{{ name }}'

/etc/default/mumble-server_{{ name }}:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://mumble-servers/mumble-server.default
{% endfor %}
