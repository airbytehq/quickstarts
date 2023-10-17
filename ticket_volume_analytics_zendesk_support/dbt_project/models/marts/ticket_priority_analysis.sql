with ticket_priority_counts as (
  select
    priority,
    count(*) as ticket_count
  from {{ ref('stg_tickets') }}
  group by 1
)
select * from ticket_priority_counts