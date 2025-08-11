{{ config(materialized='view') }}

SELECT
    id::integer AS veranstaltung_id,
    kurztitel AS titel,
    kategorie,
    COALESCE(unterkategorie, 'Nicht Zugeordnet') AS unterkategorie, --'Nicht Zugeordnet' als Standard für NULL-Werte 
    datum_beginn::date AS start_datum,
    datum_ende::date AS ende_datum,
    landname AS land,
    ort,
    REPLACE(va_name, E'\r\n', ' ') AS veranstalter_name
FROM
    {{ ref('Veranstaltungen') }}