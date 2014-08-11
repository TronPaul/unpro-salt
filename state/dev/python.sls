{% set pyversions = ['2.7', '3.4'] %}

deadsnakes-ppa:
  pkg.installed:
    - name: python-software-properties
  pkgrepo.managed:
    - ppa: fkrull/deadsnakes

packages:
  pkg.installed:
    - names:
      {% for v in pyversions %}
      - python{{ v }}
      - python{{ v }}-dev
      {% endfor %}
      - python-pip
    - require:
      - pkgrepo: deadsnakes-ppa

virtualenv:
  pip.installed:
    - require:
      - pkg: python-pip

/usr/bin/inve:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://dev/inve

/etc/bash.bashrc:
  file.append:
    - source: salt://dev/inve.bashrc
