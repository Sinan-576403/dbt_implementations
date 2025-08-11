{% snapshot scd_auslastung_its %}
  {{
    config(
      target_schema = 'snapshots',
      unique_key    = 'auslastung_its_kategorie_id',
      strategy      = 'check',
      check_cols    = ['bezeichnung', 'min_wert', 'max_wert']
    )
  }}
  select *
  from {{ ref('dim_auslastung_its') }}
{% endsnapshot %}
