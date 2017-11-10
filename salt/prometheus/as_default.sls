{% from "prometheus/prometheus.map" import prometheus with context %}

{{ prometheus.data_dir }}:
  file.directory:
    - makedirs: True
    - mode: 0755
    - user: {{ prometheus.user }}

install-prometheus:
  cmd.run:
    - cwd: {{ prometheus.dir }}
    - name: wget https://github.com/prometheus/prometheus/releases/download/v{{ prometheus.version }}/prometheus-{{ prometheus.version }}.linux-amd64.tar.gz ; tar -xf prometheus-{{ prometheus.version }}.linux-amd64.tar.gz
    - unless: ls {{ prometheus.dir }} | grep prometheus-{{ prometheus.version }}

{% if prometheus.start_with == 'upstart' %}
/etc/init/prometheus.conf:
  file.managed:
    - source: salt://prometheus/files/start/upstart/prometheus
    - mode: 755
    - user: root
    - group: root
    - template: jinja
    - watch_in:
      - service: prometheus
{% endif %}
{% if prometheus.start_with == 'initd' %}
/etc/init.d/prometheus:
  file.managed:
    - source: salt://prometheus/files/start/init.d/prometheus
    - mode: 755
    - user: root
    - group: root
    - template: jinja
    - watch_in:
      - service: prometheus
{% endif %}
{% if prometheus.start_with == 'systemd' %}
/lib/systemd/system/prometheus.service:
  file.managed:
    - source: salt://prometheus/files/start/systemd/prometheus.service
    - mode: 755
    - user: root
    - group: root
    - template: jinja
    - watch_in:
      - service: prometheus
{% endif %}

prometheus:
  service.running:
    - enable: True
    - reload: True
