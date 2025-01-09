extends Node2D

# change these to paths to each sprite
var breadArray = ['White', 'Brown', 'Multigrain']
var fillingsArray = ['Cheese', 'Eggs', 'Avocado', 'Tomato', 'Onion', 'Tuna', 'Bacon', 'Chicken', 'Crab', 'Ham']

onready var playerFillings = []
onready var playerBread = -1
onready var timeElapsed = 0
onready var totalRating = 0
onready var ordersCompleted = -1
onready var rating = 5

var ordBread = 0
var ordFillings = []
var numFillings = 0

var numIngredients = 0

onready var sandwichCont = get_node("CenterContainer/SandwichContainer/Fillings")
onready var topBreadCont = get_node("CenterContainer/SandwichContainer/TopBread")
onready var bottomBreadCont = get_node("CenterContainer/SandwichContainer/BottomBread")
const ingredientResource = preload("res://Minigame/IngredientScene.tscn")
var ingredientInstance

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

onready var orderViewCont = get_node("OrderViewContainer")

# function definitions

func generateBread():
	var bread = round(randi()%3+1)
	return bread

func generateNumFillings():
	var number = round(randi()%4+1)
	return number

func generateFillings(n):
	var fillingsArr = []
	for _i in range(n):
		fillingsArr.append(randi()%11+1)
	return fillingsArr

func emptyPlate():
	playerFillings = []
	numIngredients = 0
	playerBread = -1
	updateBread()
	updateFillingTree()


func gameLoop():
	if ordersCompleted<5:
		randomize()
		emptyPlate()
		ordersCompleted += 1
		ordBread = generateBread()
		numFillings = generateNumFillings()
		ordFillings = generateFillings(numFillings)
		updateOrderView()
		rating = 5
	else:
		var score = generateScore()
		print(score)

func updateFillingTree():

	# flush tree

	for n in sandwichCont.get_children():
		sandwichCont.remove_child(n)
		n.queue_free()

	# rerender tree

	numIngredients +=1
	for i in range(playerFillings.size()):
		ingredientInstance = ingredientResource.instance()
		ingredientInstance.name = "Ingredient" + str(numIngredients)
		ingredientInstance.texture = get('ingr'+str(playerFillings[i]+4))
		var children = sandwichCont.get_child_count()
		if children:
			sandwichCont.add_child_below_node(sandwichCont.get_child(children-1), ingredientInstance)
		else:
			sandwichCont.add_child(ingredientInstance)

func updateBread():
	var topBreadNode = ingredientResource.instance()
	topBreadNode.name = "Top Bread"
	topBreadNode.texture = get('ingr'+str(playerBread+1))
	var bottomBreadNode = topBreadNode.duplicate()
	if topBreadCont.get_child_count() == 0:
		topBreadCont.add_child(topBreadNode)
		bottomBreadCont.add_child(bottomBreadNode)
	else:
		var topChild = topBreadCont.get_children()
		var bottomChild = bottomBreadCont.get_children()

		topBreadCont.remove_child(topChild[0])
		topBreadCont.add_child(topBreadNode)

		bottomBreadCont.remove_child(bottomChild[0])
		bottomBreadCont.add_child(bottomBreadNode)

func updateOrderView():
	ingredientInstance = ingredientResource.instance()
	ingredientInstance.name = "Order Top Bread"
	ingredientInstance.texture = get('ingr'+str(ordBread+1))
	orderViewCont.add_child(ingredientInstance)

	for i in range(numFillings):
		ingredientInstance = ingredientResource.instance()
		ingredientInstance.name="Order Ingredient"+str(i)
		ingredientInstance.texture = get('ingr'+str(ordFillings[i]+1))
		orderViewCont.add_child_below_node(orderViewCont.get_child(i), ingredientInstance)
	
	ingredientInstance = ingredientResource.instance()
	ingredientInstance.name = "Order Bottom Bread"
	ingredientInstance.texture = get('ingr'+str(ordBread+1))
	orderViewCont.add_child_below_node(orderViewCont.get_child(orderViewCont.get_child_count()-1), ingredientInstance)

func calculateRating():
	var numPlayerFillings = playerFillings.size()

	if playerBread!=ordBread:
		rating-=1
	
	if numPlayerFillings!=numFillings:
		rating-=2
	else:
		var ordIngredientsUsed = 0
		for i in range(numPlayerFillings):
			if playerFillings.has(ordFillings[i]):
				ordIngredientsUsed+=1
		if ordIngredientsUsed!=numPlayerFillings:
			rating-=2
	
	if numPlayerFillings!=0:
		var preferredOrder = ordFillings.shuffle()

		var wrongCount=0
		for i in range(numPlayerFillings):
			if playerFillings[i]!=preferredOrder[i]:
				wrongCount+=1
		rating-=(wrongCount/numFillings)*2
	else:
		rating-=2 
	
	totalRating+=rating
	gameLoop()
	
func generateScore():
	var averageRating = totalRating/5
	var playerScore = round((averageRating/timeElapsed)*1000*abs(atan(averageRating)))
	return playerScore
	# tba: currency update

# filling signals

func _on_Filling1_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(0)
		updateFillingTree()

func _on_Filling2_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(1)
		updateFillingTree()

func _on_Filling3_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(2)
		updateFillingTree()

func _on_Filling4_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(3)
		updateFillingTree()

func _on_Filling5_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(4)
		updateFillingTree()

func _on_Filling6_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(5)
		updateFillingTree()

func _on_Filling7_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(6)
		updateFillingTree()

func _on_Filling8_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(7)
		updateFillingTree()

func _on_Filling9_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(8)
		updateFillingTree()

func _on_Filling10_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(9)
		updateFillingTree()

# bread signals

func _on_Bread1Butt_button_up():
	playerBread = 0
	updateBread()

func _on_Bread2Butt_button_up():
	playerBread = 1
	updateBread()

func _on_Bread3Butt_button_up():
	playerBread = 2
	updateBread()



func _on_ResetPlateButt_button_up():
	emptyPlate()

func _on_SubmitButt_button_up():
	calculateRating()

func _ready():
	gameLoop()
