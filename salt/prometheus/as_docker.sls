{% from "prometheus/prometheus.map" import prometheus with context %}

prometheus:
  docker_container.running:
    - image: {{ prometheus.docker_image }}:{{ prometheus.version }}
    - memory_swap: -1
    - memory: 2048M
    - binds:
      - {{ prometheus.data_path }}:/prometheus:rw
      - {{ prometheus.config_path }}:/etc/prometheus:rw
# salt/issues/44046
#    - ulimits:
#      - nofile=65000:65000
#      - nproc=60
    - port_bindings:
      - 9090:9090
    - watch_action: SIGHUP
