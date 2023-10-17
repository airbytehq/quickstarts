WITH contributor_analysis AS (
    SELECT 
        committer_name,
        COUNT(DISTINCT repo_name) AS repos_contributed_to,
        COUNT(*) AS number_of_commits
    FROM {{ source('github_raw', 'commits') }}
    GROUP BY 1
)

SELECT * FROM contributor_analysis
