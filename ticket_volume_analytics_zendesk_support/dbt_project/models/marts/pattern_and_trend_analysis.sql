with ticket_hourly_counts as (
  select
    extract(hour from created_at) as hour_of_day,
    count(*) as ticket_count
  from {{ ref('stg_tickets') }}
  group by 1
)
select * from ticket_hourly_counts