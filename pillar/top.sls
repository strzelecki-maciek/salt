base:
  '*':
    - base

  '{{ grains["fqdn"] }}':
    - order: 99
    - hosts.{{ grains["fqdn"].split(".")|reverse|join(".") }}

{% if grains['env'] is defined %}

  'roles:prometheus':
    - match: grain
    - groups.prometheus.{{ grains['env'] }}_shared
    - groups.prometheus.alerts

  'roles:alertmanager':
    - match: grain
    - groups.alertmanager.{{ grains['env'] }}_shared
    - groups.alertmanager.config

{% endif %}
