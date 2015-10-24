include:
  - sun-java

kibana-ppa:
  pkgrepo.managed:
    - humanname: Kibana PPA
    {% if grains['os_family'] == 'Debian' %}
    - name: deb http://packages.elastic.co/kibana/4.1/debian stable main
    - file: /etc/apt/sources.list.d/kibana.list
    - keyid: D88E42B4
    - keyserver: pgp.mit.edu
    {% endif %}

kibana:
  pkg.installed:
    - require:
      - pkgrepo: kibana-ppa
  service.running:
    - enable: True
    - require:
      - pkg: kibana
