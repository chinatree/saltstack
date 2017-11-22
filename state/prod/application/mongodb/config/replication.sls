{% set prefix = '/etc/mongodb' %}
{% set data = salt['pillar.get']('mongodb') -%}

create {{ prefix }} folder:
  file.directory:
    - name: {{ prefix }}
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true

create {{ data['systemLog']['path_prefix'] }} folder:
  file.directory:
    - name: {{ data['systemLog']['path_prefix'] }}
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true

{% for replSetName in data['replications'] %}
{% set repl_data = data['replications'][replSetName] %}

{% if repl_data.has_key('instances') %}

push {{ repl_data['security']['keyFile'] }} file for {{ replSetName }}:
  file.managed:
    - name: {{ repl_data['security']['keyFile'] }}
    - source: salt://{{ repl_data['security']['salt_source_file'] }}
    - mode: 600
    - user: root
    - group: root

{% for instance in repl_data['instances'] %}

create {{ data['storage']['dbPath_prefix'] }}/{{ replSetName }}_{{ instance['role'] }} folder:
  file.directory:
    - name: {{ data['storage']['dbPath_prefix'] }}/{{ replSetName }}_{{ instance['role'] }}
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true

push {{ replSetName }}_{{ instance['role'] }} file:
  file.managed:
    - name: {{ prefix }}/{{ replSetName }}_{{ instance['role'] }}.conf
    - source: salt://application/mongodb/files/replication.conf.jinja
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    - defaults:
      global_data: {{ data }}
      data: {{ repl_data }}
      instance: {{ instance }}
      replSetName: {{ replSetName }}

{% endfor %}

{% endif %}

{% endfor %}
