from google.cloud import bigquery
import os
from matplotlib import pyplot as plt

# Path to your BigQuery service account key
service_account_key_path = os.environ.get('DBT_BIGQUERY_KEYFILE_PATH')

# Initialize the BigQuery client
client = bigquery.Client.from_service_account_json(service_account_key_path)

# SQL query to categorize customers based on their activity level
query = """
WITH customer_activity AS (
    SELECT
        id,
        orders_count,
        CASE
            WHEN orders_count >= 10 THEN 'Highly Active'
            WHEN orders_count >= 5 THEN 'Moderately Active'
            ELSE 'Low Activity'
        END AS activity_level
    FROM transformed_data.stg_customers
)
SELECT
    id,
    orders_count,
    activity_level
FROM customer_activity
"""

# Run the query
query_job = client.query(query)

# Get the results
results = query_job.result()

# Extract the data
customer_ids = []
orders_counts = []
activity_levels = []

for row in results:
    customer_ids.append(row.id)
    orders_counts.append(row.orders_count)
    activity_levels.append(row.activity_level)

# Create a bar chart to visualize the data
plt.figure(figsize=(10, 6))
plt.bar(activity_levels, orders_counts, width=0.6, align='center', alpha=0.7)
plt.xlabel('Activity Level')
plt.ylabel('Number of Customers')
plt.title('Customer Activity Level Segmentation')
plt.grid(axis='y', linestyle='--', alpha=0.6)
plt.show()
