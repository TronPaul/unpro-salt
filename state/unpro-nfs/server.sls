include:
  - nfs.server

{% for bind in salt['pillar.get']('unpro-nfs:server:binds', []) %}
/export/{{bind.name}}:
  file.directory:
    - user: root
    - group: root
    - makedirs: True
    - dirmode: 755
  mount.mounted:
    - device: {{bind.path}}
    - fstype: none
    - opts: bind
    - mkmnt: True
    - require:
      - file: /export/{{bind.name}}
    - require_in:
      - service: nfs-service
{% endfor %}
