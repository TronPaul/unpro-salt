users:
  tron:
    groups:
      - users
      - sudo
    ssh_auth:
      tron_laptop:
        enc: ssh-rsa
        source: salt://ssh_keys/tron_laptop.id_rsa.pub
      tron_desktop:
        enc: ssh-rsa
        source: salt://ssh_keys/tron_desktop.id_rsa.pub
  stolentoast:
    groups:
      - users
    ssh_auth:
      stolentoast:
        enc: ssh-rsa
        source: salt://ssh_keys/stolentoast.id_rsa.pub
