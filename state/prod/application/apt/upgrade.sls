upgrade installed package:
  cmd.run:
    - name: apt-get --assume-yes -q --no-install-recommends -o Dpkg::Options::=--force-confold upgrade
    - cwd: /tmp
