{% set prefix = "/etc/init.d" %}
{% set name = "elasticsearch" %}
{% set source_prefix = "salt://application/elastic/elasticsearch/files" %}
{% set user = 'root' %}
{% set group = 'root' %}

push {{ prefix }}/{{ name }} file:
  file.managed:
    - name: {{ prefix }}/{{ name }}
    - source: {{ source_prefix }}/{{ name }}
    - mode: 755
    - user: {{ user }}
    - group: {{ group }}
    - onlyif:
      - test ! -f {{ prefix }}/{{ name }}

add {{ prefix }}/{{ name }} to boot startup:
  cmd.run:
    - name: update-rc.d {{ name }} defaults 95
    - cwd: /etc/init.d
