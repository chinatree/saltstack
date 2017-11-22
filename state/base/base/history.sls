create history logs forlder:
  file.directory:
    - name: /backup/logs/history
    - makedirs: True
    - dir_mode: 777

define history file:
  file.managed:
    - name: /etc/define_history
    - source: salt://base/files/define_history
    - mode: 644
    - user: root
    - group: root

append source command to /etc/profile:
  cmd.run:
    - name: echo 'source /etc/define_history' >> /etc/profile
    - unless: ! grep 'source /etc/define_history' /etc/profile
    - require:
      - file: /etc/define_history
