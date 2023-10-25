from google.cloud import bigquery
import os

from matplotlib import pyplot as plt

service_account_key_path = os.environ.get('DBT_BIGQUERY_KEYFILE_PATH')

client = bigquery.Client.from_service_account_json(service_account_key_path)

query = """
SELECT
    DATE(CreatedDate) AS date,
    COUNT(*) AS campsite_count
FROM
    transformed_data.stg_campsites
GROUP BY
    date
ORDER BY
    date
"""

query_job = client.query(query)

results = list(query_job.result())

dates = [row.date for row in results]
campsite_counts = [row.campsite_count for row in results]

plt.figure(figsize=(10, 6))
plt.plot(dates, campsite_counts, marker='o')
plt.xlabel('Date')
plt.ylabel('Campsite Count')
plt.title('Campsite Availability Over Time')
plt.show()