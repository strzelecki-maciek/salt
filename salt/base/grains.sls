{% for k,v in pillar['grains'].items() -%}
{{ k }}:
  grains.present:
    - value: {{ v }}
    - force: True
{% endfor -%}
