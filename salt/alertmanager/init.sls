{% from "alertmanager/alertmanager.map" import alertmanager with context %}

{% if alertmanager.deployment == 'docker' %}

include:
  - docker.deps
  - alertmanager.as_docker
  - alertmanager.config

{% else %}

include:
  - alertmanager.as_deb
  - alertmanager.config

{% endif %}
