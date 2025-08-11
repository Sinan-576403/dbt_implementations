{{ config(materialized='table') }}

WITH basis AS (
    SELECT
        datum::date,
        DATE_TRUNC('week', datum)::date AS woche,
        neue_faelle,
        its_belegung,
        inzidenz_7tage
    FROM {{ ref('int_covid_trends') }}
),

aggregiert AS (
    SELECT
        woche,
        COUNT(*) AS anzahl_tage,
        SUM(neue_faelle) AS summe_neue_faelle,
        ROUND(AVG(neue_faelle), 1) AS avg_neue_faelle,
        MAX(neue_faelle) AS max_neue_faelle,
        ROUND(AVG(its_belegung), 3) AS avg_its_belegung,
        MAX(its_belegung) AS max_its_belegung,
        ROUND(AVG(inzidenz_7tage), 1) AS avg_inzidenz_7tage
    FROM basis
    GROUP BY woche
)

SELECT * FROM aggregiert
ORDER BY woche
