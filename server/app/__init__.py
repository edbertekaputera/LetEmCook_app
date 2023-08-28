from flask import Flask
from config import Config
from dotenv import load_dotenv
from .initLlama import init_llama, init_json
import torch

app = Flask(__name__)
app.config.from_object(Config)

# Llama
llama_model = init_llama()

# Pytorch
MODEL_PATH = "./model/vit_mla_cpu.pt"
MODEL_LABELS_PATH = "./model/vit_mla_labels.json"
MODEL_COLOR_PATH =  "./model/vit_mla_rgb_map.json"
MODEL_COLOR_HEX_PATH = "./model/vit_mla_hexcode_map.json"

# Check that MPS is available
if not torch.backends.mps.is_available():
    if not torch.backends.mps.is_built():
        print("MPS not available because the current PyTorch install was not "
              "built with MPS enabled.")
    else:
        print("MPS not available because the current MacOS version is not 12.3+ "
              "and/or you do not have an MPS-enabled device on this machine.")

else:
    mps_device = torch.device("mps")
    print("MPS Available")
    
model = torch.load(MODEL_PATH, map_location=mps_device)
model.to(mps_device)

# Torch model labels/colormaps
labelmap = init_json(MODEL_LABELS_PATH)
colormap = init_json(MODEL_COLOR_PATH)
hexmap = init_json(MODEL_COLOR_HEX_PATH)

from app import routes