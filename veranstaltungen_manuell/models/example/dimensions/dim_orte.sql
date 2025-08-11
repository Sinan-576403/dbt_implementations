{{ config(materialized='table') }}

SELECT DISTINCT
    ort,
    land
FROM
    {{ ref('stg_veranstaltungen') }}