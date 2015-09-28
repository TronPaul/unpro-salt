{% set servers = salt['pillar.get']('openvpn:server', {}).values() %}

include:
  - openvpn

{% for server in servers %}
{% if 'secret' in server %}
/etc/openvpn/{{server['secret'}}:
  file.managed:
    - owner: root
    - group: root
    - mode: 600
    - source: salt://unpro-openvpn/{{server['secret'}}
    - require_in:
      - service: openvpn
{% else %}
/etc/openvpn/{{server['ca']}}:
  file.managed:
    - source: salt://unpro-openvpn/{{server['ca']}}
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn

/etc/openvpn/{{server['cert']}}:
  file.managed:
    - source: salt://unpro-openvpn/{{server['cert']}}
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn

/etc/openvpn/{{server['key']}}:
  file.managed:
    - source: salt://unpro-openvpn/{{server['key']}}
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn

/etc/openvpn/{{server['dh']}}:
  file.managed:
    - source: salt://unpro-openvpn/{{server['dh']}}
    - user: root
    - group: root
    - mode: 400
    - watch_in:
      - service: openvpn
{% endif %}
{% endfor %}
