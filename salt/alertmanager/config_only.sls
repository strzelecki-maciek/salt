{% from "alertmanager/alertmanager.map" import alertmanager with context %}

alertmanager_config:
  file.managed:
    - template: jinja
    - backup: minion
    - source: salt://alertmanager/files/alertmanager.yml
    - name: {{ alertmanager.config_path }}/config.yml 
    - makedirs: true
