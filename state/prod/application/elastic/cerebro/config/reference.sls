{% set prefix = "/opt/cerebro/conf" %}
{% set name = "reference.conf" %}
{% set source_prefix = "salt://application/elastic/cerebro/files" %}
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
    - onlf:
      - test -d {{ prefix }}
