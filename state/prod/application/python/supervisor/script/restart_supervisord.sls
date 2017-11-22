stop supervisord:
  cmd.run:
    - name: kill `cat /var/run/supervisord.pid`
    - cwd: /tmp

start supervisord:
  cmd.run:
    - name: /usr/local/bin/supervisord -c /etc/supervisor/supervisord.conf
    - cwd: /tmp
