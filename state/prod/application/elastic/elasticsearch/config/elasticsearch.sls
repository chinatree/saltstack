{% set prefix = "/opt/elasticsearch/config" %}
{% set name = "elasticsearch.yml" %}
{% set source_prefix = "salt://application/elastic/elasticsearch/files" %}
{% set user = "elasticsearch" %}
{% set group = "elasticsearch" %}

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
