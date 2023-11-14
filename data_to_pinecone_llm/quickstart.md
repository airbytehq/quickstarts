# Quick Start

```bash
# Change to the quickstart directory
cd data_to_pinecone_llm

# Create a new `.env` file from the template
cp .env.template .env

# Edit the `.env` file and provide all needed variables
code .env

# Export the .env file variables
set -o allexport && source .env && set +o allexport

# Deploy terraform
terraform -chdir=infra/airbyte init
terraform -chdir=infra/airbyte apply

# Print Airbyte Cloud workspace URL
terraform -chdir=infra/airbyte output

# In Airbyte Cloud:
# 1. Peform any needed fine-tuning or debugging.
# 2. Run the source data connection at least once.

# Build dbt models
dbt run --project-dir=dbt_project --profiles-dir=dbt_project

# In Airbyte Cloud:
# 1. Create the publish connection if needed.
# 2. Run the publish connection at least once.

# Create and activate the virtual environment for the AI chatbot
python -m venv .venv
source .venv/bin/activate

# Run the chatbot
./query.py
```

Please see the [Readme](README.md) for more detailed instructions.
