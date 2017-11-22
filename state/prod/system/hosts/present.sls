{% set data = salt['pillar.get']('hosts:present') %}
{% for host in data %}
{{ host['ip'] }}:
  host.present:
    - ip: {{ host['ip'] }}
    - names:
{% for hostname in host['hostnames'] %}
      - {{ hostname }}
{% endfor %}
{% endfor %}
