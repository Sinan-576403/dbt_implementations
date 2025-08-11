{{ config(materialized='table') }}

SELECT
    veranstaltung_id,
    start_datum,
    ende_datum,
    dauer_in_tagen,
    -- Fremdschlüssel zu den Dimensionen
    kategorie,
    unterkategorie,
    ort,
    land
FROM
    {{ ref('int_veranstaltungen_bereinigt') }}