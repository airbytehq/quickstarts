SELECT
    a.ActivityName,
    COUNT(r.RecAreaID) AS rec_area_count
FROM
    transformed_data.stg_activities AS a
LEFT JOIN
    transformed_data.stg_recreationareas AS r
ON
    a.ActivityID = CAST(JSON_EXTRACT_SCALAR(r.ACTIVITY, '$.ActivityID') AS INT64)
GROUP BY
    a.ActivityName
