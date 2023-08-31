from app import app
from flask import request
from app.createRecipes import createRecipes
from .segmentation import segment_pipeline, get_label_map, process_image_for_flutter
import base64
import torch

@app.route("/api/test")
def test():
    return {"status": "success"}

# sample request: http://localhost:5000/api/getRecipe?ingredients="onion, rice, beef, egg, chili"
@app.route("/api/getRecipe", methods=["GET"])
def getRecipe():
    ingredients = request.args.get("ingredients")
    recipe = createRecipes(ingredients)
    return recipe

# API for segmentation
@app.route("/api/image_segment", methods=["POST"])
def image():
	if request.method == "POST":
		file = request.files["image"]
		output = {"status": "fail"}
		im_bytes = file.read()
		img = segment_pipeline(im_bytes)
		np_segments = img[0].type(torch.uint8).cpu().numpy()
                
        # Overlaying
		processed_output = process_image_for_flutter(img[1], np_segments)
		print(processed_output.shape)
		encoded = base64.b64encode(processed_output)
		output["image"] = encoded.decode('ascii')
		# Add found labels
		output["labelmap"] = get_label_map(np_segments)
		output["status"] = "success"
		return output
    
    
