{% set prefix = '/etc/mongodb' %}
{% set source_prefix = "application/mongodb/files" %}
{% set name = "start.sh" %}
{% set data = salt['pillar.get']('mongodb') -%}

push {{ prefix }}/{{ name }} file:
  file.managed:
    - name: {{ prefix }}/{{ name }}
    - source: salt://{{ source_prefix }}/{{ name }}
    - mode: 755
    - user: root
    - group: root
    - template: jinja

{% for replSetName in data['replications'] %}
{% set repl_data = data['replications'][replSetName] %}
{% if repl_data.has_key('instances') %}
{% for instance in repl_data['instances'] %}
start {{ replSetName }}_{{ instance['role'] }} instance:
  cmd.run:
    - name: {{ prefix }}/{{ name }} {{ prefix }}/{{ replSetName }}_{{ instance['role'] }}.conf
    - cwd: /tmp
{% endfor %}
{% endif %}
{% endfor %}
