include:
  - docker

base-images:
  docker.pulled:
    - names:
      - busybox
      - jimeh/znc
    - require:
      - pip: docker-py

znc-data-container:
  docker.installed:
    - name: znc-data
    - image: busybox
    - command: echo Data-only container for znc
    - require:
      - docker: base-images

znc-container:
  docker.installed:
    - name: znc
    - image: jimeh/znc
    - ports:
      - 61753:6667
    - require:
      - docker: znc-data-container

znc-data:
  docker.running:
    - container: znc-data
    - volumes:
      - /znc-data
    - require:
      - docker: znc-data-container

znc:
  docker.running:
    - container: znc
    - volumes_from:
      - znc-data
    - require:
      - docker: znc-data
