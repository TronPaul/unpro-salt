python-dev:
  pkg:
    - installed

python-virtualenv:
  pkg:
    - installed

python3-virtualenv:
  pkg:
    - installed

python3-dev:
  pkg:
    - installed

/usr/bin/inve:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://dev/inve

/etc/bash.bashrc:
  file.append:
    - source: salt://dev/inve.bashrc
