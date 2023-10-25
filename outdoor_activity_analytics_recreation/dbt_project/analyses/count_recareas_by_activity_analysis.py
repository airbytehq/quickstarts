from google.cloud import bigquery
import os

from matplotlib import pyplot as plt

service_account_key_path = os.environ.get('DBT_BIGQUERY_KEYFILE_PATH')

client = bigquery.Client.from_service_account_json(service_account_key_path)

query = """
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
"""

query_job = client.query(query)

results = list(query_job.result())

activity_names = [row.ActivityName for row in results]
rec_area_counts = [row.rec_area_count for row in results]

plt.figure(figsize=(10, 6))
plt.barh(activity_names, rec_area_counts)
plt.xlabel('Recreational Area Count')
plt.ylabel('Activity Name')
plt.title('Recreational Area Count by Activity')
plt.show()