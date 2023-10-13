WITH commit_analysis AS (
    SELECT 
        committer_name,
        COUNT(*) AS number_of_commits,
        AVG(LENGTH(commit_message)) AS avg_commit_message_length
    FROM {{ source('github_raw', 'commits') }}
    GROUP BY 1
)

SELECT * FROM commit_analysis