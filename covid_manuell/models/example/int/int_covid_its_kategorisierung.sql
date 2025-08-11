{{ config(materialized='table') }}

SELECT
    *,

    -- Kategorisierung in hoch, mittel, niedrig
    CASE 
        WHEN COALESCE(its_belegung, 0) > 0.8 THEN 'hoch'
        WHEN COALESCE(its_belegung, 0) > 0.4 THEN 'mittel'
        ELSE 'niedrig'
    END AS auslastung_its_kategorie

FROM {{ ref('stg_covid') }}