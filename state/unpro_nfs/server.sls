include:
  - nfs

{% for bind in salt['pillar.get']('nfs:server:binds', []) %}
/export/{{name}}:
  mount.mounted:
    - device: {{mount_conf['source']}}
    - fstype: none
    - opts: bind
    - persist: True
    - mount: True
    - require_in:
      - service: nfs-service
{% endfor %}
