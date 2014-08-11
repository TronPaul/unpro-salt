include:
  - dev.python

uwsgi-build-dir:
  file.directory:
    - name: /tmp/uwsgi

get-uwsgi:
  file.managed:
    - name: /usr/local/src/uwsgi-2.0.6.tar.gz
    - source: https://github.com/unbit/uwsgi/archive/2.0.6.tar.gz
    - source_hash: md5=50e9657ebbf52dd3bcd57b565f6b65a5
  cmd.wait:
    - name: tar -zxf /usr/local/src/uwsgi-2.0.6.tar.gz -C /tmp/uwsgi
    - require:
      - file: uwsgi-build-dir
    - watch:
      - file: get-uwsgi

uwsgi-plugin-dir:
  file.directory:
    - name: /usr/lib/uwsgi

install-uwsgi:
  cmd.wait:
    - cwd: /tmp/uwsgi/uwsgi-2.0.6
    - names:
      - python3.4 uwsgiconfig.py --build package
      - python3.4 uwsgiconfig.py --plugin plugins/python package python34
      - python2.7 uwsgiconfig.py --plugin plugins/python package python27
      - cp uwsgi /usr/bin/uwsgi
    - watch:
      - cmd: get-uwsgi
    - require:
      - cmd: get-uwsgi
      - file: uwsgi-plugin-dir
