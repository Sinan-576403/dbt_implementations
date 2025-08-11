{{ config(materialized='view') }}

with source as (

    select * from {{ ref('int_veranstaltungen_saeuberung') }}

),

zeitlich as (

    select
        id,
        ort,
        kategorie,
        unterkategorie,
        datum_beginn,
        datum_ende,
        extract(year from datum_beginn) as jahr,
        extract(month from datum_beginn) as monat,
        extract(dow from datum_beginn) as wochentag,
        datum_ende - datum_beginn + 1 as dauer_tage
    from source

)

select * from zeitlich
