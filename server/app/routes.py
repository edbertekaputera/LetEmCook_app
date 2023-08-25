from app import app
from flask import request
from app.createRecipes import createRecipes

@app.route("/api/test")
def test():
    return {"status": "success"}

# sample request: http://localhost:5000/api/getRecipe?ingredients="onion, rice, beef, egg, chili"
@app.route("/api/getRecipe", methods=["GET"])
def getRecipe():
    ingredients = request.args.get("ingredients")
    recipe = createRecipes(ingredients)
    return recipe