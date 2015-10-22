include:
  - logstash
  - sun-java
  - sun-java.alternatives

extend:
  /etc/logstash/conf.d:
    file.recurse:
      - source: salt://unpro-logstash/conf.d
      - template: jinja
      - require:
        - pkg: logstash

