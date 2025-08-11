{{ config(materialized='view') }}

with source as (

    select * from {{ ref('int_veranstaltungen_saeuberung') }}

),

kontakt as (

    select
        id,
        va_name,
        va_adresse,
        va_telefon,
        va_fax,
        va_email,
        va_internet,
        case
            when va_email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' then true
            else false
        end as email_valid,
        case
            when va_internet ~* '^https?://.*' then true
            else false
        end as internet_valid
    from source

)

select * from kontakt
