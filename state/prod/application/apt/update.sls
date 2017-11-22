update apt cache:
  cmd.run:
    - name: apt-get update
    - cwd: /tmp
