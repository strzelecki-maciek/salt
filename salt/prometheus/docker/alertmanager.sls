{% from "prometheus/map.jinja" import settings with context %}

include:
  - prometheus.docker_deps

alertmanager_config:
  file.managed:
    - template: jinja
    - source: salt://prometheus/files/alertmanager.yml
    - name: {{ settings.alertmanager.config_path }}/config.yml 

alertmanager:
  docker_container.running:
    - image: {{ settings.alertmanager.docker_image }}:{{ settings.alertmanager.docker_tag }}
    - memory_swap: -1
    - memory: 512M
    - binds:
      - {{ settings.alertmanager.config_path }}:/etc/alertmanager:rw
    - ulimits:
      - nofile=65000:65000
      - nproc=60
    - watch_action: SIGHUP
    - port_bindings:
      - 9093:9093
