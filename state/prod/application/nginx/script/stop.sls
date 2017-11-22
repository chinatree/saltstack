{% set prefix = '/opt/nginx' %}

reload nginx:
  cmd.run:
    - name: /opt/nginx/sbin/nginx -s quit
    - cwd: {{ prefix }}
    - mode: 644
    - onlyif:
      - ! /opt/nginx/sbin/nginx -t
