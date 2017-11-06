python-pip:
  pkg.installed

install_dockerpy:
  pip.installed:
    - name: docker
    - upgrade: True
