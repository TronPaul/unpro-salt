include:
  - sun-java

lazybot:
  user.present:
    - system: True

/usr/share/lazybot:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/etc/init.d/lazybot:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://lazybot/lazybot.init.d

/var/log/lazybot:
  file.directory:
    - user: lazybot
    - group: lazybot
    - mode: 755
    - require:
      - user: lazybot
