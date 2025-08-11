{{ config(materialized='table') }}

SELECT DISTINCT
    kategorie,
    unterkategorie
FROM
    {{ ref('stg_veranstaltungen') }}