znc:
{% if 'ec2' in grains %}
  config_source: s3://{{bucket}}/{{backup_path}}
{% else %}
  config_source:
{% endif %}
