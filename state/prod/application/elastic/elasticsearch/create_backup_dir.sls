{% for repo in salt['pillar.get']('elastic:elasticsearch:elasticsearch:path:repo') %}
create {{ repo }} folder:
  file.directory:
    - name: {{ repo }}
    - user: elasticsearch
    - group: elasticsearch
    - dir_mode: 777
    - makedirs: true
{% endfor %}
