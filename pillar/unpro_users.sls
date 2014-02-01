users:
  tron:
    groups:
      - users
      - sudo
    ssh_auth:
      tron_laptop:
        enc: ssh-rsa
        source: salt://ssh_keys/tron_laptop.id_rsa.pub
  stolentoast:
    groups:
      - users
