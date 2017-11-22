{% set prefix = '/opt' %}
{% set name = 'kibana' %}
{% set version = '5.3.0' %}
{% set package_version = '5.3.0-linux-x86_64' %}
{% set suffix = 'tar.gz' %}
{% set sha1 = '4e9daf275f8ef749fba931c1f5c35f85662efd53' %}
{% set download_domain = 'file.topvdn.com' %}
{% set source_prefix = "http://" + download_domain + "/elastic" %}

create {{ prefix }} folder:
  file.directory:
    - name: {{ prefix }}
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: true

push {{ name }}-{{ package_version }}.{{ suffix }} packet:
  file.managed:
    - name: {{ prefix }}/{{ name }}-{{ package_version }}.{{ suffix }}
    - source: {{ source_prefix }}/{{ name }}-{{ package_version }}.{{ suffix }}
    - source_hash: sha1={{ sha1 }}
    - mode: 644
    - user: root
    - group: root

unpack {{ name }}-{{ package_version }}.{{ suffix }} packet:
  cmd.run:
    - name: tar xf {{ name }}-{{ package_version }}.{{ suffix }}
    - cwd: {{ prefix }}
    - onlyif:
      - test -f {{ name }}-{{ package_version }}.{{ suffix }}
      - test ! -d {{ name }}-{{ version }}
      - test ! -d {{ name }}-{{ package_version }}

move {{ name }}-{{ package_version }} to {{ name }}-{{ version }}:
  cmd.run:
    - name: mv {{ name }}-{{ package_version }} {{ name }}-{{ version }}
    - cwd: {{ prefix }}
    - onlyif:
      - test -d {{ prefix }}/{{ name }}-{{ package_version }}

create a symbolic link from {{ name }}-{{ version }} to {{ name }}:
  cmd.run:
    - name: ln -sf {{ name }}-{{ version }} {{ name }}
    - cwd: {{ prefix }}
    - onlyif:
      - test ! -f {{ name }}
      - test ! -h {{ name }}
      - test -d {{ prefix }}/{{ name }}-{{ version }}

absent {{ prefix }}/{{ name }}-{{ package_version }}.{{ suffix }} file:
  file.absent:
    - name: {{ prefix }}/{{ name }}-{{ package_version }}.{{ suffix }}
    - onlyif:
      - test -f {{ prefix }}/{{ name }}-{{ package_version }}.{{ suffix }}

change permissions:
  cmd.run:
    - name: chown -R  root.root {{ prefix }}/{{ name }}-{{ version }}
    - cwd: {{ prefix }}/{{ name }}-{{ version }}
    - onlyif:
      - test -d {{ prefix }}/{{ name }}-{{ version }}

absent {{ prefix }}/{{ name }}/bin/*.bat file:
  cmd.run:
    - name: rm -f {{ prefix }}/{{ name }}/bin/*.bat
    - cwd: {{ prefix }}/{{ name }}
    - onlyif:
      - test -d {{ prefix }}/{{ name }}/bin
