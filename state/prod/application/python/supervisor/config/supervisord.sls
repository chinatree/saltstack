push supervisord.conf script:
  file.managed:
    - name: /etc/supervisor/supervisord.conf
    - source: salt://application/python/supervisor/files/supervisord.conf
    - mode: 644
    - user: root
    - group: root
    - onlf:
      - test -d /etc/supervisor
