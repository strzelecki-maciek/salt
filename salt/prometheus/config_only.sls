{% from "prometheus/prometheus.map" import prometheus with context %}

prometheus_config:
  file.managed:
    - template: jinja
    - source: salt://prometheus/files/prometheus.yml
    - name: {{ prometheus.config_path }}/prometheus.yml 
    - makedirs: True

{% for alert_group in prometheus.alerts %}
{{ prometheus.alert_rules_path }}/{{ alert_group }}.rules:
  file.managed:
    - template: jinja
    - source: salt://prometheus/files/alert_rules.jinja
    - makedirs: True
    - context:
      alert_group: {{ alert_group }}
{% endfor %}

