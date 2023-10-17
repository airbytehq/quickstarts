Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

## This project

We've created two dbt models: example (which contains the default dbt example from jaffle-shop) and  ecommerce, which uses data from the dataset extracted via airbyte using the Faker source.

This project is being orchestrated via Apache Airflow using the [Astronomer Cosmos](https://astronomer.github.io/astronomer-cosmos/) project. For more details in orchestrating dbt models with Airflow, you can check the `orchestration` folder in this quickstart.

The ecommerce dbt model was forked and updated from the [Ecommerce Analytics Bigquery Quickstart](https://github.com/airbytehq/quickstarts/tree/main/ecommerce_analytics_bigquery).