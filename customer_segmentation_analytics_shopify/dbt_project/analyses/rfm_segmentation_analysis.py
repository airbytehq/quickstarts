from google.cloud import bigquery
import os
from matplotlib import pyplot as plt

# Path to your BigQuery service account key
service_account_key_path = os.environ.get('DBT_BIGQUERY_KEYFILE_PATH')

# Initialize the BigQuery client
client = bigquery.Client.from_service_account_json(service_account_key_path)

# SQL query to categorize customers based on RFM segments
query = """
WITH rfm_data AS (
    SELECT
        user_id,
        MAX(created_at) AS last_purchase_date,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(amount) AS total_spent
    FROM transformed_data.stg_transactions
    GROUP BY user_id
),
rfm_segments AS (
    SELECT
        user_id,
        CASE
            WHEN TIMESTAMP_DIFF(CAST(CURRENT_DATE AS TIMESTAMP), last_purchase_date, DAY) <= 30 THEN 'Active'
            WHEN total_orders >= 5 THEN 'Loyal'
            WHEN total_spent >= 500 THEN 'High-Spending'
            ELSE 'Churned'
        END AS rfm_segment
    FROM rfm_data
)
SELECT * FROM rfm_segments
"""

# Run the query
query_job = client.query(query)

# Get the results
results = query_job.result()

# Extract the data
user_ids = []
rfm_segments = []

for row in results:
    user_ids.append(row.user_id)
    rfm_segments.append(row.rfm_segment)

# Count the number of customers in each segment
segment_counts = {segment: rfm_segments.count(segment) for segment in set(rfm_segments)}

# Create a bar chart to visualize the data
segments, counts = zip(*segment_counts.items())

plt.figure(figsize=(10, 6))
plt.bar(segments, counts, width=0.6, align='center', alpha=0.7)
plt.xlabel('RFM Segment')
plt.ylabel('Number of Customers')
plt.title('Customer RFM Segmentation')
plt.grid(axis='y', linestyle='--', alpha=0.6)
plt.show()
