import os 
from dotenv import load_dotenv

basedir = os.path.abspath(os.path.dirname(__file__))
load_dotenv(os.path.join(basedir, '../.env'))

class Config(object):
	SECRET_KEY = os.environ.get('SECRET_KEY') or 'default-flask-key'
	FLASK_APP = os.environ.get('FLASK_APP') or 'application.py'
	LLAMA_PATH = os.environ.get('LLAMA_PATH')
	SEGMENT_MODEL_PATH = os.environ.get('SEGMENT_MODEL_PATH')
	LABELS_PATH = os.environ.get('LABELS_PATH')
	HEXCODE_PATH = os.environ.get('HEXCODE_PATH')
	RGB_PATH = os.environ.get('RGB_PATH')