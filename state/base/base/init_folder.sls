{% set prefix = "/opt/sa_tools/scripts" %}

create {{ prefix }}/sh folder:
  file.directory:
    - name: {{ prefix }}/sh
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true

create {{ prefix }}/py folder:
  file.directory:
    - name: {{ prefix }}/py
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true
