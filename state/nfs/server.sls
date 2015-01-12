nfs-kernel-server:
  pkg:
    - installed
  service.running:
    - require:
      - file: /etc/exports
      - cmd: add-fstab-binds

{% for name, mount_conf in salt['pillar.get']('nfs:mounts', {}).items() %}
/export/{{ name }}:
  file.directory:
    - user: root
    - group: root
    - makedirs: True
    - dirmode: 755
    - require_in:
      - file: add-fstab-binds

{{name}}_mount:
  file.directory:
    - name: {{ mount_conf['source'] }}
    - require_in:
      - cmd: add-fstab-binds
{% endfor %}

add-fstab-binds:
  file.append:
    - name: /etc/fstab
    - source: salt://nfs/fstab-binds
    - template: jinja
  cmd.wait:
    - name: mount -a
    - watch:
      - file: add-fstab-binds

/etc/exports:
  file.managed:
    - source: salt://nfs/exports
    - user: root
    - group: root
    - template: jinja
