{% set source_prefix = "salt://application/nginx/files" %}
{% set name = "boot_startup.sh" %}

run {{ source_prefix }}/{{ name }} script:
  cmd.script:
    - source: {{ source_prefix }}/{{ name }}
    - cwd: /tmp
