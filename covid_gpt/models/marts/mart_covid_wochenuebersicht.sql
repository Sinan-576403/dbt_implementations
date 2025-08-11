{{ config(materialized='table') }}

WITH basis AS (
    SELECT
        date_trunc('week', datum) AS woche,
        neue_faelle,
        todesfaelle,
        inzidenz_7tage,
        its_belegung
    FROM {{ ref('int_covid_saeuberung') }}
),

wochenaggregation AS (
    SELECT
        woche,
        SUM(neue_faelle) AS summe_neue_faelle,
        SUM(todesfaelle) AS summe_todesfaelle,
        MAX(inzidenz_7tage) AS max_inzidenz_7tage,
        ROUND(AVG(its_belegung)::numeric, 3) AS avg_its_belegung
    FROM basis
    GROUP BY woche
    ORDER BY woche
)

SELECT * FROM wochenaggregation
