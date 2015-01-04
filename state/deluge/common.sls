deluge-ppa:
  pkgrepo.managed:
    - humanname: Deluge PPA
    - name: deb http://ppa.launchpad.net/deluge-team/ppa/ubuntu trusty main
    - file: /etc/apt/sources.list.d/deluge.list
    - keyid: 249AD24C
    - keyserver: keyserver.ubuntu.com

deluge:
  user.present:
    - system: True

/srv/deluge:
  file.directory:
    - user: deluge
    - group: deluge
    - mode: 755
    - makedirs: True
