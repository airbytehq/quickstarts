import shutil, os, re
def fix_file():
    
    with open('/opt/airflow/plugins/templates/dbt/dbt_index.html') as f:
        html_contents = f.read()
    
    # Define a regular expression to match the script tag
    script_regex = r'<script type="text/javascript">(.*?)</script>'

    # Find the script tag that you want to extract
    script_match = re.search(script_regex, html_contents, re.DOTALL)

    # Get the contents of the script tag
    script_contents = script_match.group(1)

    # Write the script contents to a separate JavaScript file
    if not os.path.exists('/opt/airflow/plugins/static'):
      os.makedirs('/opt/airflow/plugins/static')
    with open('/opt/airflow/plugins/static/script.js', 'w') as f:
        f.write(script_contents)

    # Remove the script tag from the HTML contents
    html_contents = html_contents.replace(script_contents,"")

    # Add a new script tag to the head section of the HTML contents
    new_script_tag = f'<script type="text/javascript" src="./script.js"></script>'
    head_regex = r'<head>(.*?)</head>'
    head_match = re.search(head_regex, html_contents, re.DOTALL)
    head_contents = head_match.group(1)
    head_contents += new_script_tag
    html_contents = re.sub(head_regex, '<head>' + head_contents + '</head>', html_contents, flags=re.DOTALL)

    # Write the modified HTML contents to a new file
    with open('/opt/airflow/plugins/templates/dbt/index.html', 'w') as f:
        f.write(html_contents)

def upload_docs(project_dir):
    # upload docs to a storage of your choice
    # you only need to upload the following files:
    # - f"{project_dir}/target/index.html"
    # - f"{project_dir}/target/manifest.json"
    # - f"{project_dir}/target/graph.gpickle"
    # - f"{project_dir}/target/catalog.json"

    shutil.move(f"{project_dir}/target/index.html", "/opt/airflow/plugins/templates/dbt/dbt_index.html")
    shutil.move(f"{project_dir}/target/manifest.json", "/opt/airflow/plugins/static/manifest.json")
    shutil.move(f"{project_dir}/target/graph.gpickle", "/opt/airflow/plugins/static/graph.gpickle")
    shutil.move(f"{project_dir}/target/catalog.json", "/opt/airflow/plugins/static/catalog.json")
    fix_file()
    pass