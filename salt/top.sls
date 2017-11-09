base:
  '*':
    - base.grains
    - salt

  'roles:docker':
    - match: grain
    - docker

  'roles:alertmanager':
    - match: grain
    - alertmanager

  'roles:prometheus':
    - match: grain
    - prometheus
