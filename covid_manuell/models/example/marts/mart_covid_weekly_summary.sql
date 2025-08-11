{{ config(materialized='table') }}

WITH enriched_data AS (
    SELECT * FROM {{ ref('int_covid_its_kategorisierung') }}
),

-- Führt die finale wöchentliche Aggregation durch.
final_aggregation AS (
    SELECT
        DATE_TRUNC('week', datum)::date AS woche,
        
        COALESCE(SUM(neue_faelle), 0) AS summe_neue_faelle_pro_woche,
        COALESCE(SUM(todesfaelle), 0) AS summe_todesfaelle_pro_woche,
        MAX(inzidenz_7tage) AS hoechste_inzidenz_der_woche,
        COALESCE(ROUND(AVG(its_belegung)::numeric, 2), 0) AS durchschnittliche_its_auslastung

    FROM enriched_data
    GROUP BY 1
)

SELECT * FROM final_aggregation
ORDER BY woche DESC