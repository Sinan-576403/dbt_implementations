{{ config(materialized='table') }}

-- Erstellt eine eindeutige Zeile für jeden Tag, der in unseren Daten vorkommt.
SELECT DISTINCT
    datum::date AS datum_id,
    datum::date AS voll_datum,
    EXTRACT(YEAR FROM datum) AS jahr,
    EXTRACT(MONTH FROM datum) AS monat,
    EXTRACT(WEEK FROM datum) AS kalenderwoche,
    EXTRACT(DOW FROM datum) AS wochentag_nr --(0=Sonntag, 1=Montag, etc.)
FROM 
    {{ ref('stg_covid') }}
WHERE 
    datum IS NOT NULL
ORDER BY
    datum_id
