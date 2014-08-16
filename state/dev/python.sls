include:
  - python
  - users

{% for name, user in salt['pillar.get']('users').items() -%}
{%- if user == None -%}
{%- set user = {} -%}
{%- endif -%}
{%- set home = user.get('home', "/home/%s" % name) -%}
bashrc-{{ name }}:
  file.append:
    - name: {{ home }}/.bashrc
    - text: PATH="$PATH:{{ home }}/.local/bin"

pew-{{ name }}:
  pip.installed:
    - name: pew
    - user: {{ name }}
    - install_options:
      - --user
    - require:
      - pkg: python-pip
      - user: {{ name }}
{%- endfor -%}
