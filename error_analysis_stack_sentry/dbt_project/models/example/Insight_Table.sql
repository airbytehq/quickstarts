
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with insight_table as (
    SELECT t1.METADATA as METADATA, t1.TITLE as TITLE, t1.LEVEL as LEVEL, t1.CULPRIT as CULPRIT, t2.USER as USER
    FROM {{ source('snowflake', 'issues') }} AS t1
    INNER JOIN {{ source('snowflake', 'events') }} AS t2
    ON t1.ID = t2.GROUPID
)

select *
from insight_table

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
