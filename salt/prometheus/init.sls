{% from "prometheus/prometheus.map" import prometheus with context %}

{% if prometheus.deployment == 'docker' %}

include:
  - docker.deps
  - prometheus.as_docker
  - prometheus.config

{% else %}

include:
  - prometheus.as_default
  - prometheus.config

{% endif %}
