deluge-ppa:
  pkgrepo.managed:
    - humanname: Deluge PPA
    - name: deb http://ppa.launchpad.net/deluge-team/ppa/ubuntu precise main
    - file: /etc/apt/sources.list.d/deluge.list
    - keyid: 249AD24C
    - keyserver: keyserver.ubuntu.com

deluge:
  user.present:
    - system: True
