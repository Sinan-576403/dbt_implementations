{{ config(materialized='table') }}

WITH basis AS (
  SELECT *
  FROM {{ ref('int_covid_saeuberung') }}
),

mit_durchschnitt AS (
  SELECT
    *,
    AVG(neue_faelle) OVER (
      ORDER BY datum
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS neue_faelle_3tage_avg,

    neue_faelle - LAG(neue_faelle) OVER (
      ORDER BY datum
    ) AS delta_neue_faelle,

    AVG(inzidenz_7tage) OVER (
      ORDER BY datum
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS inzidenz_7tage_avg

  FROM basis
)

SELECT * FROM mit_durchschnitt
