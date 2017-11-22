{%set source_prefix = 'application/ntp/files' %}
{%set name = 'absent_crontab.sh' %}

run {{ name }} script:
  cmd.script:
    - source: salt://{{ source_prefix }}/{{ name }}
    - cwd: /tmp
