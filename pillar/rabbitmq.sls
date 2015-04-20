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
      - password: foobar
      - runas: root
    admin:
      - password: foobar
      - runas: root
      - tags: administrator
