{% set default_password = 'foobar' %}
sensu:
  client:
    embedded_ruby: true
    nagios_plugins: true
  rabbitmq:
    host: {{rabbitmq_host}}
    password: {{rabbitmq_password if rabbitmq_password is defined else default_password}}
  redis:
    host: {{redis_host if redis_host is defined else 'localhost'}}
    port: 6379
  api:
    password: {{api_password if api_password is defined else default_password}}
  uchiwa:
    user: tron
    password: {{uchiwa_password if uchiwa_password is defined else default_password}}
    sites:
      us-east-1: {}
  sites:
    password: {{api_password if api_password is defined else default_password}}
