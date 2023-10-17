with ticket_resolution_times as (
  select
    TIMESTAMP_DIFF(solved_at, created_at, HOUR) as resolution_time,
    count(*) as ticket_count
  from transformed_data.stg_ticket_metrics
  where solved_at is not null
  group by 1
)
select * from ticket_resolution_times