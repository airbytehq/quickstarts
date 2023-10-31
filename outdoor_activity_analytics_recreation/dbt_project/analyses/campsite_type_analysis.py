from google.cloud import bigquery
import os

from matplotlib import pyplot as plt

service_account_key_path = os.environ.get('DBT_BIGQUERY_KEYFILE_PATH')

client = bigquery.Client.from_service_account_json(service_account_key_path)

query = """
SELECT
    CampsiteType,
    COUNT(*) AS campsite_count
FROM
    transformed_data.stg_campsites
GROUP BY
    CampsiteType
"""

query_job = client.query(query)

results = list(query_job.result())

campsite_types = [row.CampsiteType for row in results]
campsite_counts = [row.campsite_count for row in results]

plt.figure(figsize=(10, 6))
plt.barh(campsite_types, campsite_counts)
plt.xlabel('Campsite Count')
plt.ylabel('Campsite Type')
plt.title('Campsite Count by Campsite Type')
plt.show()
