nfs-common:
  pkg.installed

{% for name, mount_conf in salt['pillar.get']('nfs_client:mounts', {}).items() %}
{% set mount_point = mount_conf['mount_point'] %}
{{ name }}-mount:
  file.directory:
    - name: {{ mount_point }}
    - user: root
    - group: root
    - makedirs: True
    - dirmode: 755
    - require_in:
      - file: add-fstab-nfs-mounts
{% endfor %}

add-fstab-nfs-mounts:
  file.append:
    - name: /etc/fstab
    - source: salt://nfs/fstab-nfs-mounts
    - template: jinja
  cmd.wait:
    - name: mount -a
    - watch:
      - file: add-fstab-nfs-mounts
