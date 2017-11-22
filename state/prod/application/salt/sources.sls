add gpg-key for saltstack:
  cmd.run:
    - name: wget -O - https://repo.saltstack.com/apt/ubuntu/{{ grains['lsb_distrib_release'] }}/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
    - cwd: /tmp

push saltstack.list file:
  file.managed:
    - name: /etc/apt/sources.list.d/saltstack.list
    - source: salt://application/salt/files/saltstack.list
    - mode: 644
    - user: root
    - group: root
    - template: jinja
