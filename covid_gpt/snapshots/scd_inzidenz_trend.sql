{% snapshot scd_inzidenz_trend %}
  {{
    config(
      target_schema = 'snapshots',
      unique_key    = 'inzidenz_trend_kategorie_id',
      strategy      = 'check',
      check_cols    = ['bezeichnung', 'beschreibung', 'min_wert', 'max_wert']
    )
  }}
  select *
  from {{ ref('dim_inzidenz_trend') }}
{% endsnapshot %}
