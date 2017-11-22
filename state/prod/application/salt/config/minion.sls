{% set prefix = "/etc/salt" %}
{% set name = "minion" %}

push {{ prefix }}/{{ name }} file:
  file.managed:
    - name: {{ prefix }}/{{ name }}
    - source: salt://application/salt/files/{{ name }}.jinja
    - mode: 644
    - user: root
    - group: root
    - template: jinja
