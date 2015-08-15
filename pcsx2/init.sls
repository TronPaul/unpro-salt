include:
  - xinit

enable-i386:
  cmd.run:
    - name: dpkg --add-architecture i386
    - unless: test $(dpkg --print-foreign-architectures) = i386

enable-multiverse:
  cmd.run:
    - name: sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list

pcsx2-ppa:
  pkgrepo.managed:
    - humanname: PCSX2 PPA
    - name: deb http://ppa.launchpad.net/gregory-hainaut/pcsx2.official.ppa/ubuntu trusty main
    - file: /etc/apt/sources.list.d/pcsx2.list
    - keyid: A36D8D60D79F0F65D2B81421508A982D7A617FF4
    - keyserver: keyserver.ubuntu.com
    - require:
      - cmd: enable-i386
      - cmd: enable-multiverse

pcsx2:
  pkg.installed:
    - name: pcsx2:i386
    - refresh: True
    - require:
      - pkgrepo: pcsx2-ppa

/usr/local/bin/pcsx2-standalone:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://pcsx2/pcsx2-standalone
