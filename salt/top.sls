base:
  '*':
    - base.grains
    - salt

{% if grains['env'] is defined %}

  'roles:docker':
    - match: grain
    - docker

  'roles:alertmanager':
    - match: grain
    - alertmanager

  'roles:prometheus':
    - match: grain
    - prometheus

{% endif %}
