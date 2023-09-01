from flask import Flask
from config import Config
from .initLlama import init_llama, init_json
import torch

app = Flask(__name__)
app.config.from_object(Config)

# Llama
llama_model = init_llama(app.config.get('LLAMA_PATH'))

# Pytorch
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
    
model = torch.load(app.config.get('SEGMENT_MODEL_PATH'), map_location=mps_device)
model.to(mps_device)

# Torch model labels/colormaps
labelmap = init_json(app.config.get('LABELS_PATH'))
colormap = init_json(app.config.get('RGB_PATH'))
hexmap = init_json(app.config.get('HEXCODE_PATH'))

from app import routes