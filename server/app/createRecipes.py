from app import llama_model
import time
import re

# expects ingredients list as one string
def createRecipes(ingredients):
	startTime = time.time()
	recipes = llama_model.predict(ingredients = ingredients)
	endTime = time.time()
	print(f"Time for predicting: {endTime - startTime}")
    
	return turnRecipesToList(recipes)

def turnRecipesToList(recipes):
	recipeList = []
	lines = recipes.split("\n")
	recipeCounter = 0

	recipeDict = {}
	ingredientsList = []
	instructionsList = []

	for i in range(len(lines)):
		line = lines[i]
		if "Dish Name" in line:
			if (not (recipeCounter == 0)):
				# set ingredients and instructions of previous recipe
				recipeDict["ingredients"] = ingredientsList
				recipeDict["instructions"] = instructionsList
				recipeList.append(recipeDict)

				# new dish name = reset recipe dict, ingredients, instructions
				recipeDict = {}
				ingredientsList = []
				instructionsList = []

				# clean line from asterisks just in case
			line = line.replace("*", "")
			recipeDict["dishName"] = line[11:]
			
			recipeCounter += 1
			
		# handle case where it returns **Ingredients**
		if line.startswith("*") and not line.startswith("**"):
			ingredientsList.append(line[2:])

		# check if line starts with 1. 2. etc
		if re.search(r"^\d+\.", line):
			instructionsList.append(line)

		# add last recipe
		if (i == len(lines) - 1):
			recipeDict["ingredients"] = ingredientsList
			recipeDict["instructions"] = instructionsList
			recipeList.append(recipeDict)
		

	return recipeList