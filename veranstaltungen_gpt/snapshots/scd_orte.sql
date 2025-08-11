{% snapshot scd_orte %}
{{
    config(
        target_schema='{{ target.schema }}',
        unique_key=['ort', 'landname'],
        strategy='timestamp',
        updated_at='snapshot_updated_at',
        invalidate_hard_deletes=True
    )
}}

select
    *,
    current_timestamp::timestamp as snapshot_updated_at
from {{ ref('dim_orte') }}

{% endsnapshot %}
