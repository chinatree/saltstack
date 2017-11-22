{% set prefix = "/etc/apt" %}
{% set name = "sources.list" %}

push {{ prefix }}/{{ name}} file:
  file.managed:
    - name: {{ prefix }}/{{ name}}
    - source: salt://application/apt/files/{{ name}}
    - mode: 644
    - user: root
    - group: root
    - template: jinja
