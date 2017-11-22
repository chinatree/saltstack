{% set prefix = "/opt/elasticsearch/config" %}
{% set name = "log4j2.properties" %}
{% set source_prefix = "salt://application/elastic/elasticsearch/files" %}
{% set user = "elasticsearch" %}
{% set group = "elasticsearch" %}

push {{ prefix }}/{{ name }} file:
  file.managed:
    - name: {{ prefix }}/{{ name }}
    - source: {{ source_prefix }}/{{ name }}
    - mode: 644
    - user: {{ user }}
    - group: {{ group }}
    - onlyif:
      - test -d {{ prefix }}
