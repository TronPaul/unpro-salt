include:
  - xinit

xbmc-ppa:
  pkgrepo.managed:
    - humanname: XBMC PPA
    - name: deb http://ppa.launchpad.net/team-xbmc/ppa/ubuntu trusty main
    - file: /etc/apt/sources.list.d/xbmc.list
    - keyid: 189701DA570C56B9488EF60A6D975C4791E7EE5E
    - keyserver: keyserver.ubuntu.com

/etc/init.d/xbmc:
  file.managed:
    - source: salt://xbmc/xbmc.init.d
    - user: root
    - group: root
    - mode: 744

xbmc:
  pkg.installed:
    - require:
      - pkgrepo: xbmc-ppa
  user.present:
    - shell: /bin/sh
    - system: True
    - home: /var/lib/xbmc
    - groups:
      - audio
      - video
      - fuse
      - cdrom
      - plugdev
  service.enabled:
    - require:
      - pkg: xbmc
      - pkg: xinit
      - user: xbmc
