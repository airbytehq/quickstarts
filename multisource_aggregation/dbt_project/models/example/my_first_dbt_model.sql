
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with pg_table as (

    select * from {{ source('bigquery', 'sample_table') }}

)

with mysql_table as (

    select * from {{ source('bigquery', 'test_table') }}

)

select *
from pg_table

union

select *
from mysql_table

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
