{% from "prometheus/prometheus.map" import prometheus with context %}

prometheus:
  service.running:
    - enabled: True
    - watch_action: SIGHUP
