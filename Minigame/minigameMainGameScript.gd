extends Node2D

# initialise game variables


# change these to paths to each sprite
var breadArray = ['White', 'Brown', 'Multigrain']
var fillingsArray = ['Cheese', 'Eggs', 'Avocado', 'Tomato', 'Onion', 'Tuna', 'Bacon', 'Chicken', 'Crab', 'Ham']

onready var playerFillings = []
onready var playerBread = 0
onready var timeElapsed = 0
onready var totalRating = 0
onready var ordersCompleted = -1

var ordBread = 0
var ordFillings = []
var number = 0

var numIngredients = 0

onready var sandwichCont = get_node("CenterContainer/SandwichContainer")
const ingredientResource = preload("res://Minigame/IngredientScene.tscn")

export(Texture) var ingr1
export(Texture) var ingr2
export(Texture) var ingr3
export(Texture) var ingr4
export(Texture) var ingr5
export(Texture) var ingr6
export(Texture) var ingr7
export(Texture) var ingr8
export(Texture) var ingr9
export(Texture) var ingr10
export(Texture) var ingr11
export(Texture) var ingr12
export(Texture) var ingr13

# function definitions

func generateBread():
	var bread = round(randi()%3+1)
	return bread

func generateNumFillings():
	var numFillings = round(randi()%5+1)
	return numFillings

func generateFillings(n):
	var fillingsArr = []
	for _i in range(n):
		fillingsArr.append(randi()%11+1)
	return fillingsArr

func emptyPlate():
	playerFillings = []
	numIngredients = 0

func gameLoop():
	if ordersCompleted<5:
		randomize()
		emptyPlate()
		ordersCompleted += 1
		ordBread = generateBread()
		number = generateNumFillings()
		ordFillings = generateFillings(number)
	else:
		pass # change to score screen
	
func addIngredient(index):
	var ingredientInstance = ingredientResource.instance()
	numIngredients +=1
	ingredientInstance.name = "Ingredient"+str(numIngredients)
	ingredientInstance.texture = get('ingr'+str(index))
	var children = sandwichCont.get_child_count()
	if children:
		sandwichCont.add_child_below_node(sandwichCont.get_child(children-1), ingredientInstance)
	else:
		sandwichCont.add_child(ingredientInstance)

# filling signals

func _on_Filling1_button_up():
	playerFillings.append(0)
	addIngredient(4)
	

func _on_Filling2_button_up():
	playerFillings.append(1)
	addIngredient(5)

func _on_Filling3_button_up():
	playerFillings.append(2)
	addIngredient(6)

func _on_Filling4_button_up():
	playerFillings.append(3)
	addIngredient(7)

func _on_Filling5_button_up():
	playerFillings.append(4)
	addIngredient(8)

func _on_Filling6_button_up():
	playerFillings.append(5)
	addIngredient(9)

func _on_Filling7_button_up():
	playerFillings.append(6)
	addIngredient(10)

func _on_Filling8_button_up():
	playerFillings.append(7)
	addIngredient(11)

func _on_Filling9_button_up():
	playerFillings.append(8)
	addIngredient(12)

func _on_Filling10_button_up():
	playerFillings.append(9)
	addIngredient(13)

# bread signals

func _on_Bread1Butt_button_up():
	playerBread = 0
	addIngredient(1)

func _on_Bread2Butt_button_up():
	playerBread = 1
	addIngredient(2)

func _on_Bread3Butt_button_up():
	playerBread = 2
	addIngredient(3)

func _ready():
	gameLoop()
