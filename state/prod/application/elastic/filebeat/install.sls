push filebeat_1.3.1_amd64.deb file:
  file.managed:
    - name: /opt/filebeat_1.3.1_amd64.deb
    - source: http://42.51.7.46/elastic/filebeat_1.3.1_amd64.deb
    - source_hash: sha1=5b83b54021ddb875407d6c418d9c7e4bfc93652e
    - mode: 644
    - user: root
    - group: root

install filebeat:
  cmd.run:
    - name: dpkg -i --force-confold --force-confdef filebeat_1.3.1_amd64.deb
    - cwd: /opt
    - onlyif:
      - test -f /opt/filebeat_1.3.1_amd64.deb

absent filebeat_1.3.1_amd64.deb file:
  file.absent:
    - name: /opt/filebeat_1.3.1_amd64.deb
    - onlyif:
      - test -f /opt/filebeat_1.3.1_amd64.deb
