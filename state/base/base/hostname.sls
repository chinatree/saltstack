change hostname:
  cmd.script:
    - name: salt://base/files/hostname.sh {{ grains['id'] }}
    - source: salt://base/files/hostname.sh
    - cwd: /tmp
