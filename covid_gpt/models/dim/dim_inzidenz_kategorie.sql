{{ config(materialized='table') }}

SELECT * FROM (
    VALUES
        (1, 'niedrig', 0, 9.99),
        (2, 'mittel', 10.00, 49.99),
        (3, 'hoch', 50.00, NULL)
) AS inzidenz_kategorien (
    inzidenz_kategorie_id,
    bezeichnung,
    min_wert,
    max_wert
)
