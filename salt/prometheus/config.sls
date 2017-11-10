{% from "prometheus/prometheus.map" import prometheus with context %}
{% if prometheus.deployment == 'docker' %}
include:
  - prometheus.as_docker
{% else %}
include:
  - prometheus.as_default
{% endif %}

prometheus_config:
  file.managed:
    - template: jinja
    - backup: minion
    - source: salt://prometheus/files/prometheus.yml
    - name: {{ prometheus.config_path }}/prometheus.yml 
    - makedirs: True
    - watch_in:
    {% if prometheus.deployment == 'docker' %}
      - docker_container: prometheus
    {% else %}
      - service: prometheus
    {% endif %}

{% for alert_group in prometheus.alerts %}
{{ prometheus.alert_rules_path }}/{{ alert_group }}.rules:
  file.managed:
    - template: jinja
    - backup: minion
    - source: salt://prometheus/files/alert_rules_v{{ prometheus.version }}.jinja
    - makedirs: True
    - context:
      alert_group: {{ alert_group }}
    - watch_in:
    {% if prometheus.deployment == 'docker' %}
      - docker_container: prometheus
    {% else %}
      - service: prometheus
    {% endif %}
{% endfor %}

