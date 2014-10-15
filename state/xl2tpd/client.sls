include:
  - .common

/etc/ppp/ip-up.d/50teamunpro:
  file.managed:
    - source: salt://xl2tpd/50teamunpro
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: xl2tpd
    - require_in:
      - service: xl2tpd
    - watch_in:
      - service: xl2tpd

{% for lac_name, lac_data in salt['pillar.get']('xl2tpd:lac', {}).items() -%}
/etc/ppp/options.xl2tpd.client.{{ lac_name }}:
  file.managed:
    - source: salt://xl2tpd/options.xl2tpd.client.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 600
    - replace: False
    - context:
      lac_data: {{ lac_data }}
    - require:
      - pkg: xl2tpd
    - require_in:
      - service: xl2tpd
    - watch_in:
      - service: xl2tpd
{%- endfor -%}
