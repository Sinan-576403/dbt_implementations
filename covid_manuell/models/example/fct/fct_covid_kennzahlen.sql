{{ config(materialized='table') }}

SELECT
    id,
    
    datum::date AS datum_id,
    
    -- Die messbaren "Fakten" zu Covid-19
    neue_faelle,
    todesfaelle,
    fallzahl,
    inzidenz_7tage,
    its_belegung

FROM
    {{ ref('stg_covid') }}
WHERE
    datum IS NOT NULL