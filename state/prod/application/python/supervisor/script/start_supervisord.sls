start supervisord:
  cmd.run:
    - name: /usr/local/bin/supervisord -c /etc/supervisor/supervisord.conf
    - cwd: /tmp
