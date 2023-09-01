# Let Em Cook
![Logo](https://i.postimg.cc/TY6gLt0r/let-em-cook-logo-revised.png)

## What is it
Food Recipe Generator Application with Image Semantic Segmentation.

A mobile application that takes a picture of ingredients, segments and identifies the ingredients present. The list of ingredients are used to generate a handful of recipes to cook for athletes. 

The mobile app was developed on Flutter with a local backend server developed on Flask. We detail the installation instructions to try it out yourself below.

For image segmentation, we used the ViT-MLA model trained on the FoodSeg103 dataset available [here](https://github.com/LARC-CMU-SMU/FoodSeg103-Benchmark-v1). 

For generating recipes, we used the [Llama2-7B model](https://ai.meta.com/llama/) developed by Meta. We further quantized to be able to run locally.


## Installation guide

This project requires Flutter to be installed on your system. To set it up, follow their [guide](https://docs.flutter.dev/get-started/install).

Clone the repository
```
git clone https://github.com/edbertekaputera/LetHimCook_app.git
```

### Setup server

Download model weights and labels from the following google drive [link](https://drive.google.com/drive/folders/1pU04QWS1o_5Idp7Ab6OxajPyJxuHNfTH?usp=sharing). Place them in a model folder in the following subdirectory.
```
server/app/model/llama2-7b-chat-q4.bin
server/app/model/vit_mla_cpu.pt
server/app/model/vit_mla_hexcode_map.json
server/app/model/vit_mla_labels.json
server/app/model/vit_mla_rgb_map.json
```

Also download the mmsegmentation folder from the link above. Place it under the server folder.
```
server/mmsegmentation
```

Create a .env file under the server directory. In the .env file, fill it with the following.
```
LLAMA_PATH = model/llama2-7b-chat-q4.bin
SEGMENT_MODEL_PATH = model/vit_mla_cpu.pt
LABELS_PATH = model/vit_mla_labels.json
HEXCODE_PATH = model/vit_mla_hexcode_map.json
RGB_PATH = model/vit_mla_rgb_map.json
```

Create and activate the virtual environment.
```
cd server
conda create -p ./env python=3.10 -y
conda activate ./env
```


Install pytorch.

- If you're running on a Metal GPU (Macbook M1).
```
conda install pytorch::pytorch torchvision -c pytorch -y
```

- If you're running on a CUDA GPU (Nvidia).
```
conda install pytorch torchvision pytorch-cuda=11.8 -c pytorch -c nvidia -y
```

- If you're running on CPU only.
```
conda install pytorch torchvision cpuonly -c pytorch -y
```

Install dependencies. 
```
pip install -r requirements.txt
```

Note: If you find any issues with the mmcv library installation, you can do this.
```
pip uninstall mmengine mmcv -y
pip install openmim
mim install mmengine
mim install mmcv
```

Run the server.
```
python application.py
```

### Setup mobile app
Open a new terminal window and do the following.

Note: At this moment, the app only works for IOS devices.

Install flutter dependencies.
```
cd flutter_app
flutter pub get
```

Create a .env file under the flutter_app directory. In the .env file, fill it with the following.
```
# IP address of the Flask server (You can see it on the previous terminal)
FLASK_SERVER_IP = 192.168.0.1 # Placeholder IP address
```

To run the app on your phone, see the following [guide](https://stackoverflow.com/a/54526682).

Once your phone is set up, run the app.
```
flutter run
```


## Features

Add and remove ingredients

![App Screenshot](https://i.postimg.cc/FsBTvsPz/add-remove-ingredients.jpg)


Detect ingredients in an image

![App Screenshot](https://i.postimg.cc/YSc84DBw/image-segment-food.jpg)

Generate recipes

![App Screenshot](https://i.postimg.cc/g2LN2F5D/list-of-recipes.jpg)

Recipe contents

![App Screenshot](https://i.postimg.cc/1RMWWKwp/recipe-description.jpg)


## Authors

- [@edbertekaputera](https://www.github.com/edbertekaputera)
- [@edkesuma](https://www.github.com/edkesuma)
- [@tharvus](https://www.github.com/tharvus)