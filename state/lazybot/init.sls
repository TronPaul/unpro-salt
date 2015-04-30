include:
  - sun-java

lazybot:
  user.present:
    - system: True
  service.running:
    - require:
      - user: lazybot
      - file: /etc/init/lazybot.conf
    - watch:
      - file: /etc/lazybot/config.clj

/usr/local/lazybot:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/etc/lazybot:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/etc/lazybot/config.clj:
  file.managed:
    - template: jinja
    - source: salt://lazybot/config.clj
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /etc/lazybot

/etc/init/lazybot.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://lazybot/lazybot-init.conf
    - require:
      - user: lazybot
      - file: /var/log/lazybot
      - file: /usr/local/lazybot
      - file: /etc/lazybot/config.clj

/var/log/lazybot:
  file.directory:
    - user: lazybot
    - group: lazybot
    - mode: 755
    - require:
      - user: lazybot
