{% set data = salt['pillar.get']('hosts:present') %}
{% for host in data %}
{{ host['ip'] }}:
  host.only:
    - hostnames:
{% for hostname in host['hostnames'] %}
      - {{ hostname }}
{% endfor %}
{% endfor %}
