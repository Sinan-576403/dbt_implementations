{{ config(materialized='table') }}

with base as (
    select *
    from {{ ref('stg_veranstaltungen') }}
),

parsed_datum as (
    select
        *,
        date_trunc('month', datum_beginn) as monat,
        coalesce(kategorie, 'Unbekannt') as kategorie_saeuberlich
    from base
    where datum_beginn is not null
),

aggregiert as (
    select
        monat,
        kategorie_saeuberlich,
        count(*)::integer as anzahl_veranstaltungen
    from parsed_datum
    group by monat, kategorie_saeuberlich
    order by monat, anzahl_veranstaltungen desc
)

select 
    monat,
    kategorie_saeuberlich as kategorie,
    anzahl_veranstaltungen
from aggregiert
