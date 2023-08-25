from flask import Flask
from config import Config
from dotenv import load_dotenv
from .initLlama import initLlama

app = Flask(__name__)
app.config.from_object(Config)

llama_model = initLlama()

from app import routes