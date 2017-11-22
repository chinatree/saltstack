{% set prefix = '/opt' %}
{% set proc_name = 'mongodb' %}
{% set version_prefix = 'linux-x86_64' %}
{% set version = '3.0.12' %}
{% set suffix = 'tgz' %}
{% set sha1 = '4285bb2dec6aeffb032cad92b04c9ce2a2f8c584' %}

create {{ prefix }} folder:
  file.directory:
    - name: {{ prefix }}
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true

push {{ prefix }}/{{ proc_name }}-{{ version_prefix }}-{{ version }}.{{ suffix }} file:
  file.managed:
    - name: {{ prefix }}/{{ proc_name }}-{{ version_prefix }}-{{ version }}.{{ suffix }}
    - source: http://file.topvdn.com/packets/{{ proc_name }}-{{ version_prefix }}-{{ version }}.{{ suffix }}
    - source_hash: sha1={{ sha1 }}
    - mode: 644
    - user: root
    - group: root
    - onlyif:
      - test ! -f {{ prefix }}/{{ proc_name }}-{{ version }}.{{ suffix }}

unpack {{ proc_name }}-{{ version_prefix }}-{{ version }}.{{ suffix }} file:
  cmd.run:
    - name: tar xf {{ proc_name }}-{{ version_prefix }}-{{ version }}.{{ suffix }}
    - cwd: {{ prefix }}
    - onlyif:
      - test -f {{ prefix }}/{{ proc_name }}-{{ version_prefix }}-{{ version }}.{{ suffix }}
      - test ! -d {{ prefix }}/{{ proc_name }}-{{ version_prefix }}-{{ version }}
      - test ! -d {{ prefix }}/{{ proc_name }}-{{ version }}

rename {{ proc_name }}-{{ version_prefix }}-{{ version }} to {{ proc_name }}-{{ version }}:
  cmd.run:
    - name: mv {{ proc_name }}-{{ version_prefix }}-{{ version }} {{ proc_name }}-{{ version }}
    - cwd: /opt
    - onlyif:
      - test -d {{ proc_name }}-{{ version_prefix }}-{{ version }}
      - test ! -d {{ prefix }}/{{ proc_name }}-{{ version }}

create a symbolic link from {{ proc_name }}-{{ version }} to {{ proc_name }}:
  cmd.run:
    - name: ln -sf {{ proc_name }}-{{ version }} {{ proc_name }}
    - cwd: /opt
    - onlyif:
      - test ! -f {{ prefix }}/{{ proc_name }}
      - test ! -h {{ prefix }}/{{ proc_name }}
      - test -d {{ prefix }}/{{ proc_name }}-{{ version }}

absent {{ prefix }}/{{ proc_name }}-{{ version_prefix }}-{{ version }}.{{ suffix }} file:
  file.absent:
    - name: {{ prefix }}/{{ proc_name }}-{{ version_prefix }}-{{ version }}.{{ suffix }}
    - onlyif:
      - test -f {{ prefix }}/{{ proc_name }}-{{ version_prefix }}-{{ version }}.{{ suffix }}
