include:
  - ..pip.install

install supervisor for logstash:
  cmd.run:
    - name: pip install supervisor==3.3.1
    - cwd: /tmp

create /etc/supervisor/projects folder:
  file.directory:
    - name: /etc/supervisor/projects
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true

create /var/log/supervisor folder:
  file.directory:
    - name: /var/log/supervisor
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true
