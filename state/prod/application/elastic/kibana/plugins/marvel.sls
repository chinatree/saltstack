{%set prefix = '/opt/kibana/installedPlugins' %}
{%set proc_name = 'marvel' %}
{%set version = '2.4.0' %}
{%set suffix = 'tar.gz' %}
{%set sha1 = '5cae79b23e86313d375f2436cc72c9928483d1d8' %}

push {{ proc_name }}-{{ version }}.{{ suffix }} packet:
  file.managed:
    - name: {{ prefix }}/{{ proc_name }}-{{ version }}.{{ suffix }}
    - source: http://42.51.7.46/elastic/plugins/{{ proc_name }}-{{ version }}.{{ suffix }}
    - source_hash: sha1={{ sha1 }}
    - mode: 644
    - user: root
    - group: root
    - onlyif:
      - test ! -d {{ prefix }}/{{ proc_name }}

unpack {{ proc_name }}-{{ version }}.{{ suffix }} packet:
  cmd.run:
    - name: tar xf {{ proc_name }}-{{ version }}.{{ suffix }}
    - cwd: {{ prefix }}
    - onlyif:
      - test -f {{ proc_name }}-{{ version }}.{{ suffix }}
      - test ! -d {{ proc_name }}

absent {{ prefix }}/{{ proc_name }}-{{ version }}.{{ suffix }} file:
  file.absent:
    - name: {{ prefix }}/{{ proc_name }}-{{ version }}.{{ suffix }}
    - onlyif:
      - test -f {{ prefix }}/{{ proc_name }}-{{ version }}.{{ suffix }}

change permissions:
  cmd.run:
    - name: chown -R  root.root {{ prefix }}/{{ proc_name }}
    - cwd: {{ prefix }}/
    - onlyif:
      - test -d {{ prefix }}/{{ proc_name }}
