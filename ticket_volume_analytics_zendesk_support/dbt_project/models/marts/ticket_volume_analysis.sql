with ticket_counts as (
  select
    date(created_at) as ticket_date,
    count(*) as ticket_count
  from {{ ref('stg_tickets') }}
  group by 1
)
select * from ticket_counts