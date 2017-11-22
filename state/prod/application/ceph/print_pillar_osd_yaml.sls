{% for ceph_osd in pillar['ceph']['osd'] %}

ceph disk {{ ceph_osd['device'] }} fstab:
  cmd.script:
    - name: salt://application/ceph/files/print_pillar_osd_yaml.sh {{ ceph_osd['device'] }} {{ ceph_osd['mount_dir'] }}
    - source: salt://application/ceph/files/print_pillar_osd_yaml.sh
    - cwd: /tmp

{% endfor %}
