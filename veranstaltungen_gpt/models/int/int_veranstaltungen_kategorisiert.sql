{{ config(materialized='view') }}

with base as (
    select *
    from {{ ref('stg_veranstaltungen') }}
),

kategorisiert as (
    select
        kategorie,
        unterkategorie,
        count(*) as anzahl_veranstaltungen
    from base
    group by kategorie, unterkategorie
    order by anzahl_veranstaltungen desc
)

select * from kategorisiert
