WITH pr_analysis AS (
    SELECT 
        author_name,
        COUNT(*) AS number_of_prs,
        AVG(LENGTH(pr_title)) AS avg_pr_title_length
    FROM {{ source('github_raw', 'pull_requests') }}
    GROUP BY 1
)

SELECT * FROM pr_analysis
