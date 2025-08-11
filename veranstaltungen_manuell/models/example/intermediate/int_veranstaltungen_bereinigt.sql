{{ config(materialized='table') }}

SELECT
    *,
    -- Berechnet die Dauer der Veranstaltung in Tagen
    (ende_datum - start_datum) AS dauer_in_tagen
FROM
    {{ ref('stg_veranstaltungen') }}