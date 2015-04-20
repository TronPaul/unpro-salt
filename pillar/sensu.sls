sensu:
  client:
    embedded_ruby: true
    nagios_plugins: true
  rabbitmq:
    host: rabbitmq-01
    user: sensu
    password: foobar
  redis:
    host: redis-01
    port: 6379
  api:
    password: foobar
