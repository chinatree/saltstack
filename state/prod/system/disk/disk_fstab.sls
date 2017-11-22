{% for disk in pillar['disk'] %}
ceph disk {{ disk['device'] }} fstab:
  cmd.script:
    - name: salt://system/disk/files/disk_fstab.sh {{ disk['device'] }} {{ disk['mount_dir'] }} {{ disk['type'] }} {{ disk['options'] }}
    - source: salt://system/disk/files/disk_fstab.sh
    - cwd: /tmp
{% endfor %}
