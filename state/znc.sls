include:
  - docker

base-images:
  docker.pulled:
    - names:
      - busybox
      - tronpaul/znc
    - tag: latest
    - require:
      - pip: docker-py

znc-data-container:
  docker.installed:
    - name: znc-data
    - image: busybox
    - detach: true
    - command: echo Data-only container for znc
    - volumes:
      - /znc-data
    - require:
      - docker: base-images

znc-container:
  docker.installed:
    - name: znc
    - image: tronpaul/znc
    - ports:
      - "6667/tcp"
    - require:
      - docker: znc-data-container

# salt is stupid about indenting for port_bindings
znc:
  docker.running:
    - container: znc
    - port_bindings:
        "6667/tcp":
            HostIp: "0.0.0.0"
            HostPort: "61753"
    - volumes_from:
      - znc-data
    - require:
      - docker: znc-data
