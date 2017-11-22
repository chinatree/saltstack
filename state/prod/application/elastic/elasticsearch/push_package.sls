{% set prefix = '/opt' %}
{% set name = 'elasticsearch' %}
{% set version = '5.3.0' %}
{% set suffix = 'tar.gz' %}
{% set sha1 = '9273fdecb2251755887f1234d6cfcc91e44a384d' %}
{% set user = 'elasticsearch' %}
{% set group = 'elasticsearch' %}
{% set download_domain = 'file.topvdn.com' %}
{% set source_prefix = "http://" + download_domain + "/elastic" %}

create {{ prefix }} folder:
  file.directory:
    - name: {{ prefix }}
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true

push {{ name }}-{{ version }}.{{ suffix }} packet:
  file.managed:
    - name: {{ prefix }}/{{ name }}-{{ version }}.{{ suffix }}
    - source: {{ source_prefix }}/{{ name }}-{{ version }}.{{ suffix }}
    - source_hash: sha1={{ sha1 }}
    - mode: 644
    - user: root
    - group: root

unpack {{ name }}-{{ version }}.{{ suffix }} packet:
  cmd.run:
    - name: tar xf {{ name }}-{{ version }}.{{ suffix }}
    - cwd: {{ prefix }}
    - onlyif:
      - test -f {{ name }}-{{ version }}.{{ suffix }}
      - test ! -d {{ name }}-{{ version }}

create a symbolic link from {{ prefix }}/{{ name }}-{{ version }} to {{ prefix }}/{{ name }}:
  file.symlink:
    - name: {{ prefix }}/{{ name }}
    - target: {{ name }}-{{ version }}
    - force: True
    - user: {{ user }}
    - group: {{ group }}
    - onlyif:
      - test ! -f {{ prefix }}/{{ name }}
      - test ! -h {{ prefix }}/{{ name }}
      - test -d {{ prefix }}/{{ name }}-{{ version }}

absent {{ prefix }}/{{ name }}-{{ version }}.{{ suffix }} file:
  file.absent:
    - name: {{ prefix }}/{{ name }}-{{ version }}.{{ suffix }}
    - onlyif:
      - test -f {{ prefix }}/{{ name }}-{{ version }}.{{ suffix }}

absent *.bat and *.exe file:
  cmd.run:
    - name: rm -f {{ prefix }}/{{ name }}/bin/*.bat {{ prefix }}/{{ name }}/bin/*.exe
    - cwd: {{ prefix }}/{{ name }}
    - onlyif:
      - test -d {{ prefix }}/{{ name }}/bin

change permissions:
  cmd.run:
    - name: chown -R {{ user }}.{{ group }} {{ prefix }}/{{ name }}-{{ version }}
    - cwd: {{ prefix }}/{{ name }}-{{ version }}
    - onlyif:
      - test -d {{ prefix }}/{{ name }}-{{ version }}
