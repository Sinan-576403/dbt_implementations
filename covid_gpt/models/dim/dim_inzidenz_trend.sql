{{ config(materialized='table') }}

SELECT * FROM (
    VALUES
        (1, 'stark fallend', 'Wöchentliche Inzidenz fällt stark (< -10%)', -9999.0, -10.00),
        (2, 'fallend', 'Inzidenz nimmt leicht ab (-10% bis -5%)', -10.00, -5.00),
        (3, 'stabil', 'Kaum Veränderung der Inzidenz (±5%)', -5.00, 5.00),
        (4, 'steigend', 'Leichter Anstieg der Inzidenz (+5% bis +10%)', 5.00, 10.00),
        (5, 'stark steigend', 'Starker Anstieg der Inzidenz (> +10%)', 10.00, 9999.0)
) AS dim_inzidenz_trend (
    inzidenz_trend_kategorie_id,
    bezeichnung,
    beschreibung,
    min_wert,
    max_wert
)
