boot startup iptables rules:
  cmd.script:
    - source: salt://base/files/boot_startup_iptables.sh
    - cwd: /tmp
