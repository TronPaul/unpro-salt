{% for name, config in salt['pillar.get']('openvpn:server', {}).iteritems() %}
{% for file in ('secret', 'ca', 'cert', 'key') %}
{% if file in config %}
/etc/openvpn/{{config[file]}}:
  file.managed:
    - source: salt://openvpn/{{name}}/{{config[file]}}
    - require_in:
      - service: openvpn
{% endif %}
{% endfor %}
