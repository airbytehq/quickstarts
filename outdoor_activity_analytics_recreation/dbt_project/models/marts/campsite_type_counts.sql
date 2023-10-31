WITH campsite_type_counts AS (
    SELECT
        CampsiteType,
        COUNT(*) AS campsite_count
    FROM
        {{ ref('stg_campsites') }}
    GROUP BY
        CampsiteType
)

SELECT
    *
FROM
    campsite_type_counts