{% from "alertmanager/alertmanager.map" import alertmanager with context %}

alertmanager:
  docker_container.running:
    - image: {{ alertmanager.docker_image }}:{{ alertmanager.version }}
    - memory_swap: -1
    - memory: 256M
    - binds:
      - {{ alertmanager.config_path }}:/etc/alertmanager:rw
# salt/issues/44046
#    - ulimits:
#      - nofile=65000:65000
#      - nproc=60
    - port_bindings:
      - 9093:9093
      - 6783:6783
    - watch_action: SIGHUP
    - command: "-config.file=/etc/alertmanager/config.yml -storage.path=/alertmanager -mesh.peer={{ alertmanager.mesh_peer }}:6783 -mesh.peer-id={{ alertmanager.mesh_peer_id }}"

