{{ config(materialized='table') }}

SELECT
  id,
  datum,
  fallzahl,
  neue_faelle,
  todesfaelle,
  inzidenz_7tage,
  inzidenz_veraenderung,
  hospitalisierung_7tage,

  -- Ersetze NULL durch 0 für Tests und Berechnungen
  COALESCE(its_belegung, 0) AS its_belegung,

  -- Beispiel-Feature: Schätzung der aktuellen Fälle
  (COALESCE(fallzahl, 0) + COALESCE(neue_faelle, 0)) AS geschaetzte_gesamtfaelle,

  -- Beispiel: Schwellwertindikator für ITS-Auslastung
  CASE
    WHEN COALESCE(its_belegung, 0) > 0.8 THEN 'hoch'
    WHEN COALESCE(its_belegung, 0) > 0.4 THEN 'mittel'
    ELSE 'niedrig'
  END AS auslastung_its_kategorie

FROM {{ ref('stg_covid') }}
