WITH ActivityCounts AS (
    SELECT
        ra.RecAreaName,
        a.ActivityName,
        COUNT(*) AS activity_count
    FROM
        transformed_data.stg_recreationareas AS ra
    LEFT JOIN
        transformed_data.stg_activities AS a
    ON
        CAST(ra.RecAreaID AS INT64) = a.ActivityParentID
    GROUP BY
        ra.RecAreaName, a.ActivityName
)
SELECT
    RecAreaName,
    ActivityName,
    activity_count
FROM (
    SELECT
        RecAreaName,
        ActivityName,
        activity_count,
        ROW_NUMBER() OVER (PARTITION BY RecAreaName ORDER BY activity_count DESC) AS rn
    FROM ActivityCounts
)
WHERE rn = 1
