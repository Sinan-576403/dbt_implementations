{% snapshot snap_dim_kategorie %}

{{
    config(
      target_schema='snapshots',
      unique_key='kategorie_id',
      strategy='check',
      check_cols=['kategorie', 'unterkategorie'],
      invalidate_hard_deletes=True
    )
}}

select * from {{ ref('dim_kategorie') }}

{% endsnapshot %}
