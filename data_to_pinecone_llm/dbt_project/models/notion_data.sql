with recursive iterator as (
  select JSON_VALUE(parent.page_id) as parent_page_id, * from notion.blocks
  union all
  select iterator.parent_page_id, next.* from iterator
  join notion.blocks next on JSON_VALUE(next.parent.block_id) = iterator.id
),
extracted_text as (
  select
    ARRAY_TO_STRING(
      ARRAY(
        SELECT JSON_VALUE(json_values, '$.plain_text')
        FROM UNNEST(JSON_QUERY_ARRAY(paragraph, '$.rich_text')) as json_values
      ),
      ' '
    ) as paragraph_text,
    ARRAY_TO_STRING(
      ARRAY(
        SELECT JSON_VALUE(json_values, '$[0].plain_text')
        FROM
          UNNEST(JSON_QUERY_ARRAY(table_row, '$.cells'))
        as json_values
      ),
      ' '
    ) as table_row_text,
    ARRAY_TO_STRING(
      ARRAY(
        SELECT JSON_VALUE(json_values, '$.plain_text')
        FROM
          UNNEST(JSON_QUERY_ARRAY(heading_1, '$.rich_text'))
        as json_values
      ),
      ' '
    ) as heading_1_text,
    ARRAY_TO_STRING(
      ARRAY(
        SELECT JSON_VALUE(json_values, '$.plain_text')
        FROM
          UNNEST(JSON_QUERY_ARRAY(heading_2, '$.rich_text'))
        as json_values
      ),
      ' '
    ) as heading_2_text,
    ARRAY_TO_STRING(
      ARRAY(
        SELECT JSON_VALUE(json_values, '$.plain_text')
        FROM
          UNNEST(JSON_QUERY_ARRAY(heading_3, '$.rich_text'))
        as json_values
      ),
      ' '
    ) as heading_3_text,
    ARRAY_TO_STRING(
      ARRAY(
        SELECT JSON_VALUE(json_values, '$.plain_text')
        FROM UNNEST(JSON_QUERY_ARRAY(numbered_list_item, '$.rich_text')) as json_values
      ),
      ' '
    ) as numbered_list_item_text,
    ARRAY_TO_STRING(
      ARRAY(
        SELECT JSON_VALUE(json_values, '$.plain_text')
        FROM UNNEST(JSON_QUERY_ARRAY(bulleted_list_item, '$.rich_text')) as json_values
      ),
      ' '
    ) as bulleted_list_item_text,
    *
  from iterator
),
combined_text as (
  select
    parent_page_id,
    id,
    type,
    coalesce(
      IF(CHAR_LENGTH(paragraph_text) > 0, paragraph_text, null),
      IF(CHAR_LENGTH(table_row_text) > 0, table_row_text, null),
      IF(CHAR_LENGTH(heading_1_text) > 0, heading_1_text, null),
      IF(CHAR_LENGTH(heading_2_text) > 0, heading_2_text, null),
      IF(CHAR_LENGTH(heading_3_text) > 0, heading_3_text, null),
      IF(CHAR_LENGTH(numbered_list_item_text) > 0, numbered_list_item_text, null),
      IF(CHAR_LENGTH(bulleted_list_item_text) > 0, bulleted_list_item_text, null)
    ) as text
  from extracted_text
),
aggregated_text as (
  select
    parent_page_id, string_agg(text) as text
  from combined_text
  group by parent_page_id
)

select
  last_edited_time, url, ifnull(text, "") as notion_text
from aggregated_text
join notion.pages on id = parent_page_id