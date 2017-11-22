{%set prefix = '/backup/shell' %}
{%set source_prefix = 'application/ntp/files' %}
{%set logs_dir = '/backup/logs' %}
{%set name = 'ntpdate.sh' %}
{% set data = salt['pillar.get']('ntpdate') -%}

create {{ prefix }} forlder:
  file.directory:
    - name: {{ prefix }}
    - makedirs: True
    - dir_mode: 755

create {{ logs_dir }} forlder:
  file.directory:
    - name: {{ logs_dir }}
    - makedirs: True
    - dir_mode: 777

{% if data['enable'] == True %}
push {{ name }} file:
  file.managed:
    - name: {{ prefix }}/{{ name }}
    - source: salt://{{ source_prefix }}/{{ name }}
    - mode: 755
    - user: root
    - group: root
    - template: jinja
{% endif %}

run check zabbix conf script:
  cmd.script:
    - source: salt://{{ source_prefix }}/check_if_need_add_ntpdate_result.sh
    - cwd: /tmp
