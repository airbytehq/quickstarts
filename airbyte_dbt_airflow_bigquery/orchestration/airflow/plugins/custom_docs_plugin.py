"""Plugins example"""
from __future__ import annotations

from flask import Blueprint
from flask_appbuilder import BaseView, expose

from airflow.plugins_manager import AirflowPlugin
from airflow.security import permissions
from airflow.www.auth import has_access

bp = Blueprint(
    "Docs Plugin",
    __name__,
    template_folder="templates",
    static_folder="static",
    static_url_path="/dbtdocspluginview",
)

class DbtDocsPluginView(BaseView):
    """Creating a Flask-AppBuilder View"""
    default_view = "index"
    @expose("/")
    @has_access(
        [
            (permissions.ACTION_CAN_READ, permissions.RESOURCE_WEBSITE),
        ]
    )
    def index(self):
        """Create default view"""
        return self.render_template("dbt/index.html", name="DBT")

# Creating a flask blueprint

class CustomDocsPlugin(AirflowPlugin):
    """Defining the plugin class"""

    name = "Docs Plugin"
    flask_blueprints = [bp]
    appbuilder_views = [{
        "name": "dbt",
        "category": "Custom Docs",
        "view": DbtDocsPluginView()
    }]