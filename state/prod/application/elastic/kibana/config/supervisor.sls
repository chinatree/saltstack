{% set prefix = "/etc/supervisor/projects" %}
{% set name = "kibana.conf" %}
{% set source_prefix = "salt://application/elastic/kibana/files" %}
{% set user = 'root' %}
{% set group = 'root' %}

push {{ prefix }}/{{ name }} file:
  file.managed:
    - name: {{ prefix }}/{{ name }}
    - source: {{ source_prefix }}/{{ name }}
    - mode: 644
    - user: {{ user }}
    - group: {{ group }}
    - onlyif:
      - test -d {{ prefix }}
