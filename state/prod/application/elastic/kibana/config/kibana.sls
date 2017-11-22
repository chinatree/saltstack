{% set prefix = "/opt/kibana/config" %}
{% set name = "kibana.yml" %}
{% set source_prefix = "salt://application/elastic/kibana/files" %}
{% set user = 'root' %}
{% set group = 'root' %}

push {{ prefix }}/{{ name }} file:
  file.managed:
    - name: {{ prefix }}/{{ name }}
    - source: {{ source_prefix }}/{{ name }}.jinja
    - mode: 644
    - user: {{ user }}
    - group: {{ group }}
    - template: jinja
    - onlyif:
      - test -d {{ prefix }}
