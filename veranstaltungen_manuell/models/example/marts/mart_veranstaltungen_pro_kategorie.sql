{{ config(materialized='table') }}

SELECT
    d.kategorie,
    o.ort,
    COUNT(f.veranstaltung_id) AS anzahl_veranstaltungen,
    AVG(f.dauer_in_tagen) AS durchschnittliche_dauer_in_tagen
FROM
    {{ ref('fct_veranstaltungen') }} f
LEFT JOIN
    {{ ref('dim_kategorien') }} d ON f.kategorie = d.kategorie AND f.unterkategorie = d.unterkategorie
LEFT JOIN
    {{ ref('dim_orte') }} o ON f.ort = o.ort AND f.land = o.land
GROUP BY
    d.kategorie,
    o.ort
ORDER BY
    anzahl_veranstaltungen DESC