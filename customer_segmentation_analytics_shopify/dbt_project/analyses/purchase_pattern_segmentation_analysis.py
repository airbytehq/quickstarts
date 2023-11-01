from google.cloud import bigquery
import os
from matplotlib import pyplot as plt

# Path to your BigQuery service account key
service_account_key_path = os.environ.get('DBT_BIGQUERY_KEYFILE_PATH')

# Initialize the BigQuery client
client = bigquery.Client.from_service_account_json(service_account_key_path)

# SQL query to categorize customers based on their purchase behavior
query = """
WITH purchase_data AS (
    SELECT
        id,
        COUNT(*) AS total_purchases,
        SUM(total_spent) AS total_spent
    FROM transformed_data.stg_customers
    GROUP BY id
),
behavioral_segments AS (
    SELECT
        id,
        CASE
            WHEN total_purchases >= 5 AND total_spent >= 500 THEN 'High-Value Shoppers'
            WHEN total_purchases < 5 AND total_spent < 100 THEN 'Low-Value Shoppers'
            ELSE 'Regular Shoppers'
        END AS purchase_segment
    FROM purchase_data
)
SELECT * FROM behavioral_segments
"""

# Run the query
query_job = client.query(query)

# Get the results
results = query_job.result()

# Extract the data
customer_ids = []
purchase_segments = []

for row in results:
    customer_ids.append(row.id)
    purchase_segments.append(row.purchase_segment)

# Count the number of customers in each segment
segment_counts = {segment: purchase_segments.count(segment) for segment in set(purchase_segments)}

# Create a bar chart to visualize the data
segments, counts = zip(*segment_counts.items())

plt.figure(figsize=(10, 6))
plt.bar(segments, counts, width=0.6, align='center', alpha=0.7)
plt.xlabel('Purchase Behavior Segment')
plt.ylabel('Number of Customers')
plt.title('Customer Purchase Behavior Segmentation')
plt.grid(axis='y', linestyle='--', alpha=0.6)
plt.show()
