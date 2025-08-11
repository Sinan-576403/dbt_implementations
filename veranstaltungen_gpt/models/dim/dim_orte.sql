{{ config(materialized='table') }}

with base as (
    select *
    from {{ ref('stg_veranstaltungen') }}
),

orte as (
    select distinct
        ort,
        landname
    from base
    where ort is not null
)

select
    {{ dbt_utils.generate_surrogate_key(['ort', 'landname']) }} as ort_id,
    ort,
    landname
from orte
