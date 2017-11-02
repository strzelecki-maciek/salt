{% from "prometheus/map.jinja" import settings with context %}

include:
  - prometheus.docker.deps

prometheus_config:
  file.managed:
    - template: jinja
    - source: salt://prometheus/files/prometheus.yml
    - name: {{ settings.prometheus.config_path }}/prometheus.yml 

prometheus:
  docker_container.running:
    - image: {{ settings.prometheus.docker_image }}:{{ settings.prometheus.docker_tag }}
    - memory_swap: -1
    - memory: 2048M
    - binds:
      - {{ settings.prometheus.data_path }}:/prometheus:rw
      - {{ settings.prometheus.config_path }}:/etc/prometheus:rw
    - ulimits:
      - nofile=65000:65000
      - nproc=60
    - watch_action: SIGHUP
    - port_bindings:
      - 9090:9090
