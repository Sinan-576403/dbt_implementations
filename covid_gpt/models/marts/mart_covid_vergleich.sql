{{ config(materialized='table') }}

WITH tageswerte AS (
    SELECT
        datum,
        fallzahl,
        neue_faelle,
        todesfaelle,
        inzidenz_7tage,
        hospitalisierung_7tage,
        its_belegung
    FROM {{ ref('int_covid_saeuberung') }}
),

kennzahlen AS (
    SELECT
        -- Zeitspanne
        MIN(datum) AS start_datum,
        MAX(datum) AS end_datum,
        
        -- Fallzahlenvergleich
        MAX(fallzahl) AS max_fallzahl,
        MIN(fallzahl) AS min_fallzahl,
        ROUND(AVG(fallzahl), 2) AS avg_fallzahl,

        -- Neue Fälle
        MAX(neue_faelle) AS max_neue_faelle,
        MIN(neue_faelle) AS min_neue_faelle,
        ROUND(AVG(neue_faelle), 2) AS avg_neue_faelle,

        -- Todesfälle
        MAX(todesfaelle) AS max_todesfaelle,
        MIN(todesfaelle) AS min_todesfaelle,
        ROUND(AVG(todesfaelle), 2) AS avg_todesfaelle,

        -- Inzidenzvergleich
        MAX(inzidenz_7tage) AS max_inzidenz,
        MIN(inzidenz_7tage) AS min_inzidenz,
        ROUND(AVG(inzidenz_7tage), 2) AS avg_inzidenz,

        -- ITS-Belegung
        MAX(its_belegung) AS max_its,
        MIN(its_belegung) AS min_its,
        ROUND(AVG(its_belegung), 3) AS avg_its

    FROM tageswerte
)

SELECT * FROM kennzahlen
