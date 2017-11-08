{% from "alertmanager/alertmanager.map" import alertmanager with context %}
{% if alertmanager.deployment == 'docker' %}
include:
  - alertmanager.as_docker
{% else %}
include:
  - alertmanager.as_deb
{% endif %}

alertmanager_config:
  file.managed:
    - template: jinja
    - backup: minion
    - source: salt://alertmanager/files/alertmanager.yml
    - name: {{ alertmanager.config_path }}/config.yml 
    - makedirs: true
    - watch_in:
    {% if alertmanager.deployment == 'docker' %}
      - docker_container: alertmanager
    {% else %}
      - service: alertmanager
    {% endif %}

