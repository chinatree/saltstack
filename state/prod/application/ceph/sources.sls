add gpg-key for ceph:
  cmd.run:
    - name: wget -q -O- 'http://mirrors.aliyun.com/ceph/keys/release.asc' | apt-key add -
    - cwd: /tmp

push ceph.list file:
  file.managed:
    - name: /etc/apt/sources.list.d/ceph.list
    - source: salt://application/ceph/files/14.04/ceph.list
    - mode: 644
    - user: root
    - group: root
