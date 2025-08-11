{{ config(materialized='table') }}

SELECT * FROM (
    VALUES
        (1, 'niedrig', 0.00, 0.40),
        (2, 'mittel', 0.40, 0.80),
        (3, 'hoch', 0.80, 1.00)
) AS its_auslastung_kategorien (
    auslastung_its_kategorie_id,
    bezeichnung,
    min_wert,
    max_wert
)
