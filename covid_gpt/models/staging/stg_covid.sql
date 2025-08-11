{{ config(materialized='view') }}

SELECT
  id::integer,
  datum::date,

  -- Fallzahl
  CASE
    WHEN fallzahl ~ '^\d+$' THEN fallzahl::integer
    ELSE NULL
  END AS fallzahl,

  -- Neue Fälle
  CASE
    WHEN neue_faelle ~ '^\d+$' THEN neue_faelle::integer
    ELSE NULL
  END AS neue_faelle,

  -- Todesfälle
  CASE
    WHEN todesfaelle ~ '^\d+$' THEN todesfaelle::integer
    ELSE NULL
  END AS todesfaelle,

  -- 7-Tage-Inzidenz (z. B. „0,9“ → 0.9)
  CASE
    WHEN inzidenz_7tage ~ '^\d+[,.]?\d*$' THEN
      REPLACE(inzidenz_7tage, ',', '.')::numeric
    ELSE NULL
  END AS inzidenz_7tage,

  -- Veränderung der 7-Tage-Inzidenz
  CASE
    WHEN inzidenz_veraenderung ~ '^-?\d+[,.]?\d*$' THEN
      REPLACE(inzidenz_veraenderung, ',', '.')::numeric
    ELSE NULL
  END AS inzidenz_veraenderung,

  -- Hospitalisierung (7 Tage)
  CASE
    WHEN hospitalisierung_7tage ~ '^\d+[,.]?\d*$' THEN
      REPLACE(hospitalisierung_7tage, ',', '.')::numeric
    ELSE NULL
  END AS hospitalisierung_7tage,

  -- ITS-Belegung
  CASE
    WHEN its_belegung ~ '^\d+[,.]?\d*$' THEN
      LEAST(GREATEST(REPLACE(its_belegung, ',', '.')::numeric, 0), 1)
    ELSE NULL
  END AS its_belegung

FROM {{ source('covid_schema', 'covid') }}
