extends Node2D

# ingredient names for reference
# var ingrNameArray = ['White', 'Brown', 'Multigrain', 'Cheese', 'Eggs', 'Avocado', 'Tomato', 'Onion', 'Tuna', 'Bacon', 'Chicken', 'Crab', 'Ham']

# initialising variables

# player input related variables
var playerFillings = []
var playerBread = -1
var ordersCompleted = 0
var rating = 5
var totalRating = 0
var numIngredients = 0

# order related variables
var ordBread = 0
var ordFillings = []
var numFillings = 0

# random number generator class
var rng = RandomNumberGenerator.new()

# rendering related variables/container nodes
onready var sandwichCont = get_node("CenterContainer/SandwichContainer/Fillings")
onready var topBreadCont = get_node("CenterContainer/SandwichContainer/TopBread")
onready var bottomBreadCont = get_node("CenterContainer/SandwichContainer/BottomBread")

onready var orderViewCont = get_node("OrderViewContainer")

const ingredientResource = preload("res://Minigame/IngredientScene.tscn")
var ingredientInstance

# ingredient textures
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

# generates the index of the bread to be used
func generateBread():
	var bread = round(rng.randi_range(1, 3))
	print("Bread: ", bread)
	return bread

# generates the number of fillings in the order
func generateNumFillings():
	var number = round(rng.randi_range(1, 4))
	return number

# generates the fillings in the order
func generateFillings(n):
	var fillingsArr = []
	for _i in range(n):
		fillingsArr.append(rng.randi_range(4, 13))
	print("Order fillings: ", fillingsArr)
	return fillingsArr

# empties the player's plate and reinitialises the variables tracking their inputs
func emptyPlate():
	playerFillings = []
	numIngredients = 0
	playerBread = -1
	updateBread()
	updateFillingTree()

# carries out a variety of tasks to facilitate for multiple 
# rounds of gameplay and score/rating generation and storage.

# this includes creating a new seed for randomisation to occur,
# emptying the players plate, generating a new order and keeping 
# track of the number of orders completed by the player.
func gameLoop():
	if ordersCompleted<5:
		rng.randomize()
		emptyPlate()
		ordersCompleted += 1
		ordBread = generateBread()
		numFillings = generateNumFillings()
		ordFillings = generateFillings(numFillings)
		updateOrderView()
		rating = 5
	else:
		MinigameGlobals.timeElapsed = $Timer.getTime()
		print("Time elapsed: ", MinigameGlobals.timeElapsed)
		MinigameGlobals.averageRating = totalRating/5
		print("Average rating: ", MinigameGlobals.averageRating)
		MinigameGlobals.playerScore = generateScore()
		print("Score: ", MinigameGlobals.playerScore)
		MinigameGlobals.coinsEarned = MinigameGlobals.playerScore
		get_tree().change_scene("res://Minigame/minigameScoreScreenScene.tscn")


# empties and rebuilds the filling node tree to display the fillings inputted by the player
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
		ingredientInstance.texture = get('ingr'+str(playerFillings[i]))
		var children = sandwichCont.get_child_count()
		if children:
			sandwichCont.add_child_below_node(sandwichCont.get_child(children-1), ingredientInstance)
		else:
			sandwichCont.add_child(ingredientInstance)

# empties and rerenders the top and bottom bread containers to have the texture of the bread inputted by the player
func updateBread():
	# create the nodes for the top and bottom bread
	var topBreadNode = ingredientResource.instance()
	topBreadNode.name = "Top Bread"
	topBreadNode.texture = get('ingr'+str(playerBread))
	var bottomBreadNode = topBreadNode.duplicate()

	# add the bread nodes to their containers, removing the previous bread node if needed
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

# empties and rerenders the order view container to display the ingredients specified by the order
func updateOrderView():

	# flush tree
	for n in orderViewCont.get_children():
		orderViewCont.remove_child(n)
		n.queue_free()

	# rerender tree
	ingredientInstance = ingredientResource.instance()
	ingredientInstance.name = "Order Top Bread"
	ingredientInstance.texture = get('ingr'+str(ordBread))
	orderViewCont.add_child(ingredientInstance)

	for i in range(numFillings):
		ingredientInstance = ingredientResource.instance()
		ingredientInstance.name="Order Ingredient"+str(i)
		ingredientInstance.texture = get('ingr'+str(ordFillings[i]))
		orderViewCont.add_child_below_node(orderViewCont.get_child(i), ingredientInstance)
	
	ingredientInstance = ingredientResource.instance()
	ingredientInstance.name = "Order Bottom Bread"
	ingredientInstance.texture = get('ingr'+str(ordBread))
	orderViewCont.add_child_below_node(orderViewCont.get_child(orderViewCont.get_child_count()-1), ingredientInstance)

# calculates the player's rating for an order and runs gameLoop()
func calculateRating():
	var numPlayerFillings = playerFillings.size()

	# correct bread
	if playerBread!=ordBread:
		rating-=1
	
	# the right number of fillings used, and the right fillings
	if numPlayerFillings!=numFillings:
		rating-=2
	else:
		var ordIngredientsUsed = 0
		for i in range(numPlayerFillings):
			if playerFillings.has(ordFillings[i]):
				ordIngredientsUsed+=1
		if ordIngredientsUsed!=numPlayerFillings:
			rating-=2
	
	# if the fillings were in the right order (the order is a secret!)
	if numPlayerFillings!=0:
		ordFillings.shuffle()
		var wrongCount=0
		for i in range(numPlayerFillings):
			if playerFillings[i]!=ordFillings[i]:
				wrongCount+=1
		rating-=(wrongCount/numFillings)*2
	else:
		rating-=2 

	rating = round(rating)
	print("Rating: ", rating, "\n")
	
	totalRating+=rating
	gameLoop()

# generates the player's score
func generateScore():
	var playerScore = round((MinigameGlobals.averageRating/MinigameGlobals.timeElapsed)*1000*abs(atan(MinigameGlobals.averageRating)))
	return playerScore

# filling signals

func _on_Filling1_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(4)
		updateFillingTree()

func _on_Filling2_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(5)
		updateFillingTree()

func _on_Filling3_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(6)
		updateFillingTree()

func _on_Filling4_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(7)
		updateFillingTree()

func _on_Filling5_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(8)
		updateFillingTree()

func _on_Filling6_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(9)
		updateFillingTree()

func _on_Filling7_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(10)
		updateFillingTree()

func _on_Filling8_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(11)
		updateFillingTree()

func _on_Filling9_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(12)
		updateFillingTree()

func _on_Filling10_button_up():
	if playerFillings.size()<=3:
		playerFillings.append(13)
		updateFillingTree()

# bread signals

func _on_Bread1Butt_button_up():
	playerBread = 1
	updateBread()

func _on_Bread2Butt_button_up():
	playerBread = 2
	updateBread()

func _on_Bread3Butt_button_up():
	playerBread = 3
	updateBread()

# other button signals

func _on_ResetPlateButt_button_up():
	emptyPlate()

func _on_SubmitButt_button_up():
	calculateRating()

# runs on the scene loading
func _ready():
	gameLoop()
