{{ config(materialized='view') }}

with base as (
    select * from {{ ref('stg_veranstaltungen') }}
),

parsed as (
    select
        id,
        kurztitel,
        kategorie,
        unterkategorie,
        landname,
        ort,
        va_name,
        va_adresse,
        va_telefon,
        va_fax,
        va_email,
        va_internet,
        teilnehmerkreis,
        externer_link,
        lfdnr,

        -- Bereinigung und Validierung der Datumsfelder
        case 
            when datum_beginn::text ~ '^\d{4}-\d{2}-\d{2}$' then datum_beginn::date
            else null
        end as datum_beginn,

        case 
            when datum_ende::text ~ '^\d{4}-\d{2}-\d{2}$' then datum_ende::date
            else null
        end as datum_ende,

        -- Dauer der Veranstaltung in Tagen (falls beide Datumsangaben vorhanden sind)
        case 
            when datum_beginn::text ~ '^\d{4}-\d{2}-\d{2}$' 
             and datum_ende::text ~ '^\d{4}-\d{2}-\d{2}$'
            then datum_ende::date - datum_beginn::date
            else null
        end as dauer_in_tagen

    from base
)

select * from parsed
