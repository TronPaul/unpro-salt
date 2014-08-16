{% set virtualbox_version = salt['pillar.get']('virtualbox_version', '4.3') %}

virtualbox-repo:
  cmd.run:
    - name: echo 'deb http://download.virtualbox.org/virtualbox/debian '$(lsb_release -cs)' contrib non-free' > /etc/apt/sources.list.d/virtualbox.list
    - unless: test -f /etc/apt/sources.list.d/virtualbox.list

virtualbox-key:
  cmd.wait:
    - name: wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
    - watch:
      - cmd: virtualbox-repo

virtualbox-pkgs:
  pkg.installed:
    - names:
      - virtualbox-{{ virtualbox_version }}
      - dkms
    - require:
      - cmd: virtualbox-repo
