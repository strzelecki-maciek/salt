{% from "alertmanager/alertmanager.map" import alertmanager with context %}

{{ alertmanager.dir }}:
  file.directory:
    - owner: {{ alertmanager.user }}
    - makedirs: True

install-alertmanager:
  cmd.run:
    - cwd: {{ alertmanager.dir }}
    - name: wget https://github.com/prometheus/alertmanager/releases/download/v{{ alertmanager.version }}/alertmanager-{{ alertmanager.version }}.linux-amd64.tar.gz ; tar -xf alertmanager-{{ alertmanager.version }}.linux-amd64.tar.gz
    - unless: ls {{ alertmanager.dir }} | grep alertmanager-{{ alertmanager.version }}

{% if alertmanager.start_with == 'upstart' %}
/etc/init/alertmanager.conf:
  file.managed:
    - source: salt://alertmanager/files/start/upstart/alertmanager
    - mode: 755
    - user: root
    - group: root
    - template: jinja
    - watch_in:
      - service: alertmanager
{% endif %}
{% if alertmanager.start_with == 'initd' %}
/etc/init.d/alertmanager:
  file.managed:
    - source: salt://alertmanager/files/start/init.d/alertmanager
    - mode: 755
    - user: root
    - group: root
    - template: jinja
    - watch_in:
      - service: alertmanager
{% endif %}
{% if alertmanager.start_with == 'systemd' %}
/lib/systemd/system/alertmanager.service:
  file.managed:
    - source: salt://alertmanager/files/start/systemd/alertmanager.service
    - mode: 755
    - user: root
    - group: root
    - template: jinja
    - watch_in:
      - service: alertmanager
{% endif %}

alertmanager:
  service.running:
    - enable: True
