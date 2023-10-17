from cosmos.config import ProjectConfig, ProfileConfig
from cosmos.profiles import GoogleCloudServiceAccountDictProfileMapping, GoogleCloudServiceAccountFileProfileMapping


project_config = ProjectConfig(
    dbt_project_path="/opt/airflow/dbt_project",
)

google_config = GoogleCloudServiceAccountFileProfileMapping(
    conn_id="dbt_file_connection",
    profile_args={
        "dataset": "my_dataset",
        "location": "US",
        "threads": 1,
        "retries": 1,
        "priority": "interactive",
    }
)

profile_config = ProfileConfig(
    profile_name="airflow_profile",
    target_name="dev",
    profile_mapping=google_config
)
#