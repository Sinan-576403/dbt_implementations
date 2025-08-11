{{ config(materialized='table') }}

WITH basis AS (
  SELECT
    id,
    datum AS datum_id,
    fallzahl,
    neue_faelle,
    todesfaelle,
    inzidenz_7tage,
    inzidenz_veraenderung,
    hospitalisierung_7tage,
    its_belegung
  FROM {{ ref('stg_covid') }}
)

SELECT
  b.id,
  b.datum_id,
  b.fallzahl,
  b.neue_faelle,
  b.todesfaelle,
  b.inzidenz_7tage,
  b.inzidenz_veraenderung,
  b.hospitalisierung_7tage,
  b.its_belegung,

  inz.inzidenz_kategorie_id,
  its.auslastung_its_kategorie_id,
  trend.inzidenz_trend_kategorie_id

FROM basis b

-- JOIN auf dim_inzidenz_kategorie (z. B. niedrig < 10, mittel < 50, hoch >= 50)
LEFT JOIN {{ ref('dim_inzidenz_kategorie') }} inz
  ON b.inzidenz_7tage >= inz.min_wert
 AND (b.inzidenz_7tage < inz.max_wert OR inz.max_wert IS NULL)

-- JOIN auf dim_auslastung_its (z. B. niedrig ≤ 0.4, mittel ≤ 0.8, hoch > 0.8)
LEFT JOIN {{ ref('dim_auslastung_its') }} its
  ON b.its_belegung >= its.min_wert
 AND (b.its_belegung < its.max_wert OR its.max_wert IS NULL)

-- JOIN auf dim_inzidenz_trend (z. B. stark sinkend, stabil, steigend…)
LEFT JOIN {{ ref('dim_inzidenz_trend') }} trend
  ON b.inzidenz_veraenderung >= trend.min_wert
 AND (b.inzidenz_veraenderung < trend.max_wert OR trend.max_wert IS NULL)
