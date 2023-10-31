SELECT
    DATE(CreatedDate) AS date,
    COUNT(*) AS campsite_count
FROM
    transformed_data.stg_campsites
GROUP BY
    date
ORDER BY
    date