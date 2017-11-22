{% set prefix = '/usr/local/services' %}
{% set name = 'jdk' %}
{% set version = '1.8.0_121' %}
{% set package_version = '8u121-linux-x64' %}
{% set suffix = 'tar.gz' %}
{% set sha1 = '11f5925366234506730c095a2fd151d8f1212db7' %}
{% set user = 'root' %}
{% set group = 'root' %}
{% set download_domain = 'file.topvdn.com' %}
{% set source_prefix = "http://" + download_domain + "/packets" %}

#{% set jdk_version = '1.8.0_102' %}
#{% set jdk_packet_name = 'jdk-8u102-linux-x64.tar.gz' %}

create {{ prefix }} folder:
  file.directory:
    - name: {{ prefix }}
    - user: {{ user }}
    - group: {{ group }}
    - dir_mode: 755
    - makedirs: true

push {{ name }}-{{ package_version }}.{{ suffix }} packet:
  file.managed:
    - name: {{ prefix }}/{{ name }}-{{ package_version }}.{{ suffix }}
    - source: {{ source_prefix }}/{{ name }}-{{ package_version }}.{{ suffix }}
    - source_hash: sha1={{ sha1 }}
    - mode: 644
    - user: {{ user }}
    - group: {{ group }}

unpack {{ name }}-{{ package_version }}.{{ suffix }} packet:
  cmd.run:
    - name: tar xf {{ name }}-{{ package_version }}.{{ suffix }}
    - cwd: {{ prefix }}
    - onlyif:
      - test -f {{ name }}-{{ package_version }}.{{ suffix }}
      - test ! -d {{ name }}{{ version }}
      - test ! -d {{ name }}-{{ package_version }}

create a symbolic link from {{ name }}{{ version }} to {{ name }}:
  cmd.run:
    - name: ln -sf {{ name }}{{ version }} {{ name }}
    - cwd: {{ prefix }}
    - onlyif:
      - test ! -f {{ name }}
      - test ! -h {{ name }}
      - test -d {{ prefix }}/{{ name }}{{ version }}

absent {{ prefix }}/{{ name }}-{{ package_version }}.{{ suffix }} file:
  file.absent:
    - name: {{ prefix }}/{{ name }}-{{ package_version }}.{{ suffix }}
    - onlyif:
      - test -f {{ prefix }}/{{ name }}-{{ package_version }}.{{ suffix }}

change permissions:
  cmd.run:
    - name: chown -R {{ user }}.{{ group }} {{ prefix }}/{{ name }}{{ version }}
    - cwd: {{ prefix }}/{{ name }}{{ version }}
    - onlyif:
      - test -d {{ prefix }}/{{ name }}{{ version }}
