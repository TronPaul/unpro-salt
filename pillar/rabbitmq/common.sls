{% set default_password = 'foobar' %}
rabbitmq:
  plugin:
    rabbitmq_management:
      - enabled
  vhost:
    sensu:
      - user: sensu
      - conf: .*
      - write: .*
      - read: .*
  user:
    sensu:
      - password: {{sensu_password if sensu_password is defined else default_password}}
      - runas: root
    admin:
      - password: {{admin_password if admin_password is defined else default_password}}
      - runas: root
      - tags: administrator
