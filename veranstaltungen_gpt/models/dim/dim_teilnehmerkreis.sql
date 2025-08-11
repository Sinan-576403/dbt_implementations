{{ config(materialized='table') }}

with base as (
    select *
    from {{ ref('stg_veranstaltungen') }}
),

gruppen as (
    select distinct
        teilnehmerkreis
    from base
    where teilnehmerkreis is not null
)

select
    {{ dbt_utils.generate_surrogate_key(['teilnehmerkreis']) }} as teilnehmerkreis_id,
    teilnehmerkreis
from gruppen
