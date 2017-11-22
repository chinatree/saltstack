adjust sshd argv:
  cmd.script:
    - source: salt://base/files/sshd.sh
    - cwd: /tmp
