include:
  - xinit

mupen64plus-pkgs:
  pkg.installed:
    - names:
      - mupen64plus
      - mupen64plus-video-glide64

/usr/local/bin/mupen64plus-standalone:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://mupen64plus/mupen64plus-standalone

/usr/local/bin/start-mupen64plus:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://mupen64plus/start-mupen64plus
