{% snapshot snap_dim_orte %}

{{
    config(
      target_schema='snapshots',
      unique_key='ort_id',
      strategy='check',
      check_cols=['ort', 'landname'],
      invalidate_hard_deletes=True
    )
}}

select * from {{ ref('dim_orte') }}

{% endsnapshot %}
