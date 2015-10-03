include:
  - xinit

dolphin-ppa:
  pkgrepo.managed:
    - humanname: dolphin-emu
    - name: deb http://ppa.launchpad.net/glennric/dolphin-emu/ubuntu trusty main
    - file: /etc/apt/sources.list.d/dolphin.list
    - keyid: CBA82405A9D3DADD0A6647D16C843CCE8505D44B
    - keyserver: keyserver.ubuntu.com

dolphin-emu-master:
  pkg.installed:
    - require:
      - pkgrepo: dolphin-ppa

/usr/local/bin/dolphin-standalone:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://dolphin/dolphin-standalone

/usr/local/bin/start-dolphin:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://dolphin/start-dolphin
