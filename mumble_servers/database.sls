include:
  - .init
  - .package

{% for name in pillar.get('mumble_servers', {}).keys() %}
/var/lib/mumble-server/{{name}}.sqlite:
  file.managed:
    - user: mumble-server
    - group: mumble-server
    - mode: 600
    - replace: False
    - source: salt://mumble_servers/{{name}}.sqlite
    - watch_in:
      - service: mumble-server_{{name}}
    - require:
      - pkg: mumble-server
{% endfor %}
