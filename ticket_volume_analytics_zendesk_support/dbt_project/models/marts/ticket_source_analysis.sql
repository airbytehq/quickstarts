with source_data as (
  select
    JSON_EXTRACT_SCALAR(json_data, '$.channel') as ticket_source,
    count(*) as ticket_count
  from (
    select
      JSON_EXTRACT_ARRAY(via)[OFFSET(0)] as json_data
    from transformed_data.stg_tickets
  ) t
  group by 1
)
select * from source_data