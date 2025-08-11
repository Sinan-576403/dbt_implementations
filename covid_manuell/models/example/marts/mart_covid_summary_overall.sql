{{ config(materialized='table') }}

WITH stg_data AS (
    SELECT * FROM {{ ref('stg_covid') }}
)

-- Finale Aggregation über den gesamten Zeitraum
SELECT
    -- Zeitspanne der Daten
    MIN(datum) AS erstes_datum,
    MAX(datum) AS letztes_datum,
    
    -- Gesamt-Kennzahlen
    SUM(neue_faelle) AS gesamt_neue_faelle,
    SUM(todesfaelle) AS gesamt_todesfaelle,
    
    -- Extremwerte
    MAX(neue_faelle) AS hoechste_tages_fallzahl,
    MAX(inzidenz_7tage) AS hoechste_inzidenz_jemals,
    
    -- Durchschnittswerte
    ROUND(AVG(inzidenz_7tage)::numeric, 2) AS durchschnittliche_inzidenz

FROM stg_data