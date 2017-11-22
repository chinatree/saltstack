push vip.sh script:
  file.managed:
    - name: /opt/vip.sh
    - source: salt://system/net/files/vip.sh
    - mode: 755
    - user: root
    - group: root
