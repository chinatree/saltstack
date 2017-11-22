{% set prefix = '/opt' %}
{% set config_dir = '/etc/logstash' %}
{% set proc_name = 'logstash' %}
{% set version = '5.3.0' %}
{% set suffix = 'tar.gz' %}
{% set sha1 = 'ede53a40e2935768e8113b63c1a09160f849b6c4' %}
{% set download_domain = 'file.topvdn.com' %}
{% set source_prefix = "http://" + download_domain + "/elastic" %}

create {{ prefix }} folder:
  file.directory:
    - name: {{ prefix }}
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true

create {{ config_dir }} folder:
  file.directory:
    - name: {{ config_dir }}
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true

push {{ proc_name }}-{{ version }}.{{ suffix }} packet:
  file.managed:
    - name: {{ prefix }}/{{ proc_name }}-{{ version }}.{{ suffix }}
    - source: {{ source_prefix }}/{{ proc_name }}-{{ version }}.{{ suffix }}
    - source_hash: sha1={{ sha1 }}
    - mode: 644
    - user: root
    - group: root

unpack {{ proc_name }}-{{ version }}.{{ suffix }} packet:
  cmd.run:
    - name: tar xf {{ proc_name }}-{{ version }}.{{ suffix }}
    - cwd: {{ prefix }}
    - onlyif:
      - test -f {{ proc_name }}-{{ version }}.{{ suffix }}
      - test ! -d {{ proc_name }}-{{ version }}

create a symbolic link from {{ proc_name }}-{{ version }} to {{ proc_name }}:
  cmd.run:
    - name: ln -sf {{ proc_name }}-{{ version }} {{ proc_name }}
    - cwd: {{ prefix }}
    - onlyif:
      - test ! -f {{ proc_name }}
      - test ! -h {{ proc_name }}
      - test -d {{ prefix }}/{{ proc_name }}-{{ version }}

absent {{ prefix }}/{{ proc_name }}-{{ version }}.{{ suffix }} file:
  file.absent:
    - name: {{ prefix }}/{{ proc_name }}-{{ version }}.{{ suffix }}
    - onlyif:
      - test -f {{ prefix }}/{{ proc_name }}-{{ version }}.{{ suffix }}

change permissions:
  cmd.run:
    - name: chown -R root.root {{ prefix }}/{{ proc_name }}-{{ version }}
    - cwd: {{ prefix }}/{{ proc_name }}-{{ version }}
    - onlyif:
      - test -d {{ prefix }}/{{ proc_name }}-{{ version }}

absent {{ prefix }}/{{ proc_name }}/bin/*.bat file:
  cmd.run:
    - name: rm -f {{ prefix }}/{{ proc_name }}/bin/*.bat
    - cwd: {{ prefix }}/{{ proc_name }}
    - onlyif:
      - test -d {{ prefix }}/{{ proc_name }}/bin
