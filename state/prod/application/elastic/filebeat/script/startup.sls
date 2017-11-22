add to boot startup:
  cmd.run:
    - name: update-rc.d filebeat defaults 95
    - cwd: /etc/init.d
