{{ config(materialized='view') }}

with source as (

    select * from {{ ref('int_veranstaltungen_saeuberung') }}

),

zielgruppe as (

    select
        id,
        teilnehmerkreis,
        case
            when teilnehmerkreis ilike '%kinder%' then 'Kinder'
            when teilnehmerkreis ilike '%jugend%' then 'Jugendliche'
            when teilnehmerkreis ilike '%familie%' then 'Familien'
            when teilnehmerkreis ilike '%erwachsene%' then 'Erwachsene'
            else 'Sonstige'
        end as zielgruppenklassifikation
    from source

)

select * from zielgruppe
