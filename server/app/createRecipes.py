from langchain.llms import LlamaCpp
from langchain import PromptTemplate, LLMChain
import time
import re

# expects ingredients list as one string
def createRecipes(ingredients):
	B_INST, E_INST = "[INST]", "[/INST]"
	B_SYS, E_SYS = "<<SYS>>\n", "\n<</SYS>>\n\n"

	CUSTOM_SYSTEM_PROMPT="You are now a professional chef that has expertise in recipe generations"
	RULES = "Make sure you show the entire procedure for cooking it. Make sure that any extra ingredients you include are commonly found at home. Remember to include the Dish Name header."
	FORMATTING = "The structure of the recipe shall be split to three sections in the following format. Dish Name:\n Ingredients\n Instructions\n. Make sure the instructions appear in numbered format."
	SYSTEM_PROMPT = B_SYS + CUSTOM_SYSTEM_PROMPT + RULES + FORMATTING + E_SYS
	instruction = "Recommend me three different easy to cook homemade recipes with the following ingredients:\n'{ingredients}'"

	template = B_INST + SYSTEM_PROMPT + instruction + E_INST

	# template for an instruction with input
	prompt_with_context = PromptTemplate(
		input_variables=["ingredients"],
		template= template)

	model_path = './app/LLM/ggml-model-q4_0.bin'
	llm = LlamaCpp(
		model_path=model_path,
		n_gpu_layers=10,
		n_batch=2048,
		temperature=0.72,
		n_ctx=2048,
		max_tokens=2048,
		top_p=0.74,
		top_k=0,
		f16_kv=True,
		verbose=True,
	) # type: ignore


	llm_context_chain = LLMChain(llm=llm, prompt=prompt_with_context)

	startTime = time.time()
	recipes = llm_context_chain.predict(ingredients = ingredients)
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