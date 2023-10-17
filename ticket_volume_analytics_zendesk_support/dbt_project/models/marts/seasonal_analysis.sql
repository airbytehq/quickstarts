with ticket_seasonal_counts as (
  select
    extract(month from created_at) as month,
    count(*) as ticket_count
  from {{ ref('stg_tickets') }}
  group by 1
)
select * from ticket_seasonal_counts