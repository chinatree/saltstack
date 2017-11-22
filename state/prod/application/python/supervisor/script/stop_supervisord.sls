stop supervisord:
  cmd.run:
    - name: kill `cat /var/run/supervisord.pid`
    - cwd: /tmp
