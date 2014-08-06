python-pip:
  pkg.installed

docker-ppa:
  pkgrepo.managed:
    - humanname: Docker PPA
    - name: deb https://get.docker.io/ubuntu docker main
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 36A1D7869245C8950F966E92D8576A8BA88D21E9
    - keyserver: keyserver.ubuntu.com

lxc-docker:
  pkg.installed:
    - require:
      - pkgrepo: docker-ppa

docker-py:
  pip.installed:
    - require:
      - pkg: python-pip

trandpaul-container:
  docker.installed:
    - name: trandpaul
    - hostname: trandpaul
    - image: tronpaul/trandpaul

trandpaul:
  docker.running:
    - container: trandpaul
    - require:
      - pip: docker-py
      - pkg: lxc-docker
