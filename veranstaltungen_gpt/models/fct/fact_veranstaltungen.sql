{{ config(materialized='incremental') }}

with base as (
    select
        id,
        kategorie,
        unterkategorie,
        ort,
        landname,
        datum_beginn::date as beginn,
        datum_ende::date as ende,
        coalesce(datum_ende::date, datum_beginn::date) - datum_beginn::date + 1 as dauer_in_tagen
    from {{ ref('int_veranstaltungen_saeuberung') }}
),

joined as (
    select
        b.id,
        b.kategorie,
        b.unterkategorie,
        b.ort,
        b.landname,
        b.beginn,
        b.ende,
        b.dauer_in_tagen,
        k.kategorie_id,
        o.ort_id
    from base b
    left join {{ ref('dim_kategorie') }} k
        on b.kategorie = k.kategorie and b.unterkategorie = k.unterkategorie
    left join {{ ref('dim_orte') }} o
        on b.ort = o.ort and b.landname = o.landname
    where k.kategorie_id is not null and o.ort_id is not null
),

aggregiert as (
    select
        kategorie_id,
        ort_id,
        kategorie,
        unterkategorie,
        count(*) as anzahl_veranstaltungen,
        avg(dauer_in_tagen) as durchschn_dauer_tage
    from joined
    group by kategorie_id, ort_id, kategorie, unterkategorie
)

select * from aggregiert
