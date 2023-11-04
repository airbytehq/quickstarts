from google.cloud import bigquery
import os

from matplotlib import pyplot as plt

service_account_key_path = os.environ.get('DBT_BIGQUERY_KEYFILE_PATH')

client = bigquery.Client.from_service_account_json(service_account_key_path)

query = """
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
"""

query_job = client.query(query)

# Get the results
results = list(query_job.result())

# Plot the data
rec_areas = [row.RecAreaName for row in results]
common_activities = [row.ActivityName for row in results]

plt.figure(figsize=(10, 6))
plt.barh(rec_areas, common_activities)
plt.xlabel('Most Common Activity')
plt.ylabel('RecArea Name')
plt.title('Most Common Activity in RecAreas')
plt.show()