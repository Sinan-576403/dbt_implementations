{% snapshot scd_inzidenz_kategorie %}
  {{
    config(
      target_schema = 'snapshots',        
      unique_key    = 'inzidenz_kategorie_id',
      strategy      = 'check',
      check_cols    = ['bezeichnung', 'min_wert', 'max_wert']
    )
  }}
  select *
  from {{ ref('dim_inzidenz_kategorie') }}
{% endsnapshot %}
