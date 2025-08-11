with source as (
    select * from {{ ref('Veranstaltungen') }}
),

renamed as (
    select
        id,
        kurztitel,
        kategorie,
        unterkategorie,
        datum_beginn,
        datum_ende,
        terminliste,
        landname,
        ort,
        va_name,
        va_adresse,
        va_telefon,
        va_fax,
        va_email,
        va_internet,
        teilnehmerkreis,
        externer_link,
        lfdnr
    from source
)

select * from renamed
