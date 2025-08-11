{{ config(materialized='view') }}

with base as (
    select *
    from {{ ref('stg_veranstaltungen') }}
),

kommend as (
    select
        *,
        current_date as heutiges_datum,
        datum_beginn - current_date as tage_bis_beginn
    from base
    where datum_beginn >= current_date
)

select * from kommend
