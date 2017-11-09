fix-pip:
  cmd.run:
    - name: easy_install pip
    - unless: pip -V

pip-docker-py:
  cmd.run:
    - name: /usr/local/bin/pip install docker-py
    - unless: pip freeze -l | grep "docker-py=="

pip-docker:
  cmd.run:
    - name: /usr/local/bin/pip install docker
    - unless: pip freeze -l | grep "docker=="
