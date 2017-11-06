{% from "prometheus/alertmanager.map" import alertmanager with context %}

include:
  - docker.deps

alertmanager_config:
  file.managed:
    - template: jinja
    - source: salt://alertmanager/files/alertmanager.yml
    - name: {{ alertmanager.config_path }}/config.yml 

alertmanager:
  docker_container.running:
    - image: {{ alertmanager.docker_image }}:{{ alertmanager.docker_tag }}
    - memory_swap: -1
    - memory: 512M
    - binds:
      - {{ alertmanager.config_path }}:/etc/alertmanager:rw
    - watch_action: SIGHUP
    - port_bindings:
      - 9093:9093
