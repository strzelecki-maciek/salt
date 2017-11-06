{% from "alertmanager/alertmanager.map" import alertmanager with context %}

alertmanager:
  service.running:
    - enabled: True
    - watch_action: SIGHUP
