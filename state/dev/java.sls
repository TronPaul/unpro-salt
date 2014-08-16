webupd8-ppa:
  pkgrepo.managed:
    - humanname: Oracle Java (JDK) 6 / 7 / 8 Installer PPA
    - name: deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main 
    - file: /etc/apt/sources.list.d/webupd8-java.list
    - keyid: 7B2C3B0889BF5709A105D03AC2518248EEA14886
    - keyserver: keyserver.ubuntu.com
