{% set prefix = "/opt/nginx/conf" %}
{% set sites_available = prefix + "/sites-available" %}
{% set sites_enabled = prefix + "/sites-enabled" %}

create {{ sites_available }} folder:
  file.directory:
    - name: {{ sites_available }}
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true

create {{ sites_enabled }} folder:
  file.directory:
    - name: {{ sites_enabled }}
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true
