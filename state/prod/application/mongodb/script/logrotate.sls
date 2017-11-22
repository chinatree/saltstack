{% set prefix = "/etc/logrotate.d" %}
{% set name = "mongodb" %}
{% set source_prefix = "salt://application/mongodb/files/logrotate.d" %}
{% set user = 'root' %}
{% set group = 'root' %}

push {{ prefix }}/{{ name }} file:
  file.managed:
    - name: {{ prefix }}/{{ name }}
    - source: {{ source_prefix }}/{{ name }}
    - mode: 644
    - user: {{ user }}
    - group: {{ group }}
