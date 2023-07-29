# hello.py
from flask import Flask
from flask import send_file

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "Application Delivered Successfully!\nyou can download the app in /download url\n"


@app.route('/download')
def downloadFile(): #In your case fname is your filename
    try:
       path = f'./dist/add2vals'
       return send_file(path,mimetype='text/x-python', download_name='add2vals', as_attachment=True)
    except Exception as e:
        return str(e)
