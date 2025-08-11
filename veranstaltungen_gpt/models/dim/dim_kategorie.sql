{{ config(materialized='table') }}

with base as (
    select *
    from {{ ref('stg_veranstaltungen') }}
),

kategorien as (
    select distinct
        kategorie,
        unterkategorie
    from base
    where kategorie is not null
)

select
    {{ dbt_utils.generate_surrogate_key(['kategorie', 'unterkategorie']) }} as kategorie_id,
    kategorie,
    unterkategorie
from kategorien
