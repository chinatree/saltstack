{%set source_prefix = 'application/ntp/files' %}
{%set name = 'present_crontab.sh' %}
{% set data = salt['pillar.get']('ntpdate') -%}

{% if data['enable'] == True %}
run {{ name }} script:
  cmd.script:
    - source: salt://{{ source_prefix }}/{{ name }}
    - cwd: /tmp
{% endif %}
