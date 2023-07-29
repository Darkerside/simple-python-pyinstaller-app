import pytest
import json
from api import app

def test_index_route():
    response = app.test_client().get('/')

    assert response.status_code == 200
    assert response.data.decode('utf-8') == 'Application Delivered Successfully!\nyou can download the app in /download url\n'