{{ config(materialized='table') }}

SELECT DISTINCT
  datum AS datum_id,
  datum,
  EXTRACT(DOW FROM datum) AS wochentag,
  EXTRACT(WEEK FROM datum) AS kw,
  EXTRACT(MONTH FROM datum) AS monat,
  EXTRACT(YEAR FROM datum) AS jahr
FROM {{ ref('stg_covid') }}
WHERE datum IS NOT NULL
