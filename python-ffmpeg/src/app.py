# -*- coding: utf-8 -*-
from flask import Flask
import subprocess
from flask import send_from_directory
import os


app = Flask(__name__)

@app.route('/', methods=['GET'])
def ffmpeg_help():
    try:
        status = subprocess.run(['ffmpeg', '--help'])
        return 'ok'
    except Exception as e:
        app.logger.error(str(e))
        return "internal server error: {}".format(str(e)), 500
