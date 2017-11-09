{% for k,v in pillar['grains'].items() -%}
{{ k }}:
  grains.present:
    - value: {{ v }}
{% endfor -%}
