# hello.py

from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "Application Deployed Successfully\nyou can download the add2vals executable using jenkins"