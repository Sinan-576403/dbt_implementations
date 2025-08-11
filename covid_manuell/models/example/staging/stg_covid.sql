{{ config(materialized='view') }}

SELECT
    id::integer,
    datum::date,

    -- Konvertiert Spalten zu Ganzzahlen und behandelt fehlerhafte Werte als NULL
    CASE
        WHEN fallzahl::text ~ '^\d+$'
        THEN fallzahl::integer
        ELSE NULL
    END AS fallzahl,

    CASE
        WHEN neue_faelle::text ~ '^\d+$'
        THEN neue_faelle::integer
        ELSE NULL
    END AS neue_faelle,

    CASE
        WHEN todesfaelle::text ~ '^\d+$'
        THEN todesfaelle::integer
        ELSE NULL
    END AS todesfaelle,

    -- Wandelt Text mit Komma als Dezimaltrennzeichen in eine Zahl um
    CASE
        WHEN "7_tage_inzidenz"::text ~ '^\d+[,.]?\d*$'
        THEN REPLACE("7_tage_inzidenz"::text, ',', '.')::numeric
        ELSE NULL
    END AS inzidenz_7tage,
    
    -- Wandelt die ITS-Belegung um und stellt sicher, dass der Wert zwischen 0 und 1 liegt
    CASE
        WHEN its_belegung::text ~ '^\d+[,.]?\d*$'
        THEN LEAST(GREATEST(REPLACE(its_belegung::text, ',', '.')::numeric, 0), 1)
        ELSE NULL
    END AS its_belegung

FROM {{ ref('covid') }}