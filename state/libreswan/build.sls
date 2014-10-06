{% set version = salt['pillar.get']('libreswan:version', '3.10') %}
{% set hash = salt['pillar.get']('libreswan:hash', '29342ba5c92e0be22d5803092dd67e6d50965b3e') %}

build_deps:
  pkg.installed:
    - pkgs:
      - libnss3-dev
      - libnspr4-dev
      - pkg-config
      - libpam0g-dev
      - libcap-ng-dev
      - libcap-ng-utils
      - libselinux1-dev
      - libcurl4-nss-dev
      - libgmp3-dev
      - flex
      - bison
      - gcc
      - make
      - libunbound-dev
      - libnss3-tools
      - wget

/opt/src:
  file:
    - directory

download_source:
  file.managed:
    - name: /opt/src/libreswan-{{ version }}.tar.gz
    - source: https://download.libreswan.org/libreswan-{{ version }}.tar.gz
    - source_hash: sha1={{ hash }}

extract_source:
  cmd.wait:
    - name: tar xzf /opt/src/libreswan-{{ version }}.tar.gz
    - cwd: /opt/src
    - watch:
      - file: download_source

build:
  cmd.wait:
    - name: make programs
    - cwd: /opt/src/libreswan-{{ version }}
    - require:
      - pkg: build_deps
    - watch:
      - cmd: extract_source

install:
  cmd.wait:
    - name: make install
    - cwd: /opt/src/libreswan-{{ version }}
    - watch:
      - cmd: build
    - require_in:
      - service: ipsec
