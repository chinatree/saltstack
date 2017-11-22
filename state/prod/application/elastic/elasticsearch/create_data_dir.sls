{% for dir in salt['pillar.get']('elastic:elasticsearch:elasticsearch:path:data') %}
create {{ dir }} folder:
  file.directory:
    - name: {{ dir }}
    - user: elasticsearch
    - group: elasticsearch
    - dir_mode: 755
    - makedirs: true
{% endfor %}
