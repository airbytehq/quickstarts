### Run Locally

- The project is set to work with our database credentials and OpenAI API key. You will need to update the credentials to work with your own data.

- Create a folder called `.streamlit` and create a file called `secrets.toml`.

- Add the following to the `secrets.toml` file:
    ```toml
    OPENAI_API_KEY="YOUR_OPENAI_API_KEY"
    SNOWFLAKE_HOST="YOUR_SNOWFLAKE_ACCOUNT_NAME"
    SNOWFLAKE_ROLE="YOUR_SNOWFLAKE_ROLE"
    SNOWFLAKE_WAREHOUSE="YOUR_SNOWFLAKE_WAREHOUSE"
    SNOWFLAKE_DATABASE="YOUR_SNOWFLAKE_DATABASE"
    SNOWFLAKE_SCHEMA="YOUR_SNOWFLAKE_SCHEMA"
    SNOWFLAKE_USERNAME="YOUR_SNOWFLAKE_USERNAME"
    SNOWFLAKE_PASSWORD="YOUR_SNOWFLAKE_PASSWORD"
    ```

- Update the table names and LLM instructions in `app.py` with data specific to your use case.

- Create a virtual environment:
    ```bash
    python3 -m venv venv
    ```

- Activate the virtual environment:
    ```bash
    source venv/bin/activate  
    ```

- Install the requirements:
    ```bash
    pip install -r requirements.txt
    ```

- Run the app:
    ```bash
    streamlit run app.py
    ```

- Open your browser and go to [http://localhost:8501](http://localhost:8501).

### Deploy to Streamlit Community Cloud

- Copy the code into its own repository.

- Create an account [here](https://streamlit.io/cloud) and follow the instructions to give access to the repository you created.
