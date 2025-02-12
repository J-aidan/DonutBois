extends Node2D

@onready var donut = $Donut
@onready var muffin = $Muffin

var donut_positionx = 8
var donut_positiony = 7

var muffin_positionx = 8
var muffin_positiony = 8

var donut_count := 0
var donut_multiplier := 1

var muffin_count := 0
var muffin_multiplier := 1

var bar_count := 0
var bar_multiplier := 1

var cream_count := 0
var cream_multiplier := 1

var cherry_count := 0
var cherry_multiplier :=1

var grape_count := 0
var grape_multiplier := 1

var donut_node
var muffin_node

#trying to cleanly address issues where clicking is unavailable
#----------------------------------------------
var bar_enabled = false
var cream_enabled = false
var cherry_enabled = false
var grape_enabled = false
var donut_mult_enabled = false
var muffin_mult_enabled = false

var donut_speed_enabled = false
var muffin_speed_enabled = false

var donut_speed_used = false
var muffin_speed_used = false
#-----------------------------------------------

var scene2_enabled = false
var scene3_enabled = false

var scene2_owned = false
var scene3_owned = false
#-----------------------------------------------

var curr_scene = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("start")
	MusicPlayer.play_bgm()
	create_food()
	
	# trying to update speed
	donut_node = get_node("Donut")
	muffin_node = get_node("Muffin")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$DonutLabel.text = str(donut_count)
	$MuffinLabel.text = str(muffin_count)
	$BarPurchase/BarLabel.text = str(bar_count)
	$CreamPurchase/CreamLabel.text = str(cream_count)
	$CherryPurchase/CherryLabel.text = str(cherry_count)
	$GrapePurchase/GrapeLabel.text = str(grape_count)
	
	#global prices
	#chocolate button
	if(donut_count < 5):
		$BarPurchase.set_disabled(true)
	else:
		$BarPurchase.set_disabled(false)
	#cream button
	if(muffin_count < 5):
		$CreamPurchase.set_disabled(true)
	else:
		$CreamPurchase.set_disabled(false)
	
	#cherry button
	if(bar_count < 5):
		$CherryPurchase.set_disabled(true)
	else:
		$CherryPurchase.set_disabled(false)
	
	#grape button
	if(cream_count < 5):
		$GrapePurchase.set_disabled(true)
	else:
		$GrapePurchase.set_disabled(false)
	
	#donut_multiplier
	if(cherry_count < 1):
		$DonutMultiplier.set_disabled(true)
	else:
		$DonutMultiplier.set_disabled(false)
	
	#muffin_multiplier
	if(grape_count < 1):
		$MuffinMultiplier.set_disabled(true)
	else:
		$MuffinMultiplier.set_disabled(false)
		
	#donut_speed
	if donut_speed_used:
		$DonutSpeed.visible = false
	if(cherry_count < 1 or donut_speed_used):
		$DonutSpeed.set_disabled(true)
	else:
		$DonutSpeed.set_disabled(false)
	
	#muffin_speed
	if muffin_speed_used:
		$MuffinSpeed.visible = false
	if(grape_count < 1 or muffin_speed_used):
		$MuffinSpeed.set_disabled(true)
	else:
		$MuffinSpeed.set_disabled(false)
		
	#scene2
	if ((scene2_enabled and cherry_count >= 3) or (scene2_owned)):
		$Scene2.set_disabled(false)
	else:
		$Scene2.set_disabled(true)
	
	#scene3
	if (scene3_enabled and grape_count >= 3 or (scene3_owned)):
		$Scene3.set_disabled(false)
	else:
		$Scene3.set_disabled(true)

	
	# check if any buttons pressed
	if $CreamPurchase.is_pressed():
		print("Cream was pressed")
		muffins_to_icecream()
		$CreamPurchase.set_pressed(false)
	if $BarPurchase.is_pressed() and Input.is_action_just_pressed("click"):
		print("Bar was pressed")
		donuts_to_bars()
		$BarPurchase.set_pressed(false)
	if $CherryPurchase.is_pressed() and Input.is_action_just_pressed("click"):
		print("Cherry was pressed")
		bars_to_cherries()
		$CherryPurchase.set_pressed(false)
	if $GrapePurchase.is_pressed() and Input.is_action_just_pressed("click"):
		print("Grape was pressed")
		cream_to_grapes()
		$GrapePurchase.set_pressed(false)
	if $MuffinMultiplier.is_pressed() and Input.is_action_just_pressed("click"):
		print("Muffin multiplies\n")
		muffin_multiplier += 1
		grape_count -= 1
		$MuffinMultiplier.set_disabled(true)
		$MuffinMultiplier.set_pressed(false)
	if $MuffinSpeed.is_pressed() and Input.is_action_just_pressed("click"):
		print("increase muffin speed\n")
		muffin_node.SPEED = 200
		grape_count -= 1
		$MuffinSpeed.set_pressed(false)
		$MuffinSpeed.visible = false
		$MuffinSpeed.set_disabled(true)
		muffin_speed_used = true
	if $DonutMultiplier.is_pressed() and Input.is_action_just_pressed("click"):
		print("Donut multiplies\n")
		donut_multiplier += 1
		cherry_count -= 1
		$DonutMultiplier.set_disabled(true)
		$DonutMultiplier.set_pressed(false)
	if $DonutSpeed.is_pressed() and Input.is_action_just_pressed("click"):
		print("Donut speed increases\n")
		donut_node.SPEED = 200
		cherry_count -= 1
		$DonutSpeed.set_pressed(false)
		$DonutSpeed.visible = false
		$DonutSpeed.set_disabled(true)
		donut_speed_used = true
		
	if $Scene1.is_pressed() and Input.is_action_just_pressed("click"):
		curr_scene = 1
		$TileMap.visible = true
		$TileMap2.visible = true
		$TileMap3.visible = false
		$TileMap4.visible = false
		$TileMap5.visible = false
		$TileMap6.visible = false
		
		if(scene2_owned):
			$Scene2.set_disabled(false)
		if(scene3_owned):
			$Scene3.set_disabled(false)
		
		$Scene1.set_disabled(true)
	if $Scene2.is_pressed() and Input.is_action_just_pressed("click"):
		curr_scene = 2
		$TileMap.visible = false
		$TileMap2.visible = false
		$TileMap3.visible = true
		$TileMap4.visible = true
		$TileMap5.visible = false
		$TileMap6.visible = false
		
		if !scene2_owned:
			scene2_owned = true
			cherry_count -= 3
		$Scene2.set_disabled(true)
		$Scene1.set_disabled(false)
		if(scene3_owned):
			$Scene3.set_disabled(false)
	if $Scene3.is_pressed() and Input.is_action_just_pressed("click"):
		curr_scene = 3
		$TileMap.visible = false
		$TileMap2.visible = false
		$TileMap3.visible = false
		$TileMap4.visible = false
		$TileMap5.visible = true
		$TileMap6.visible = true
		
		if !scene3_owned:
			scene3_owned = true
			grape_count -= 3
		$Scene3.set_disabled(true)
		$Scene1.set_disabled(false)
		if(scene2_owned):
			$Scene2.set_disabled(false)

	pass

func increment_donuts():
	$CoinPlayer.play()
	donut_count += donut_multiplier
	print("donut count: ")
	print(donut_count)
	print("\n")
	#if donuts more than 5 purchase option open
	if donut_count >= 5:
		if !bar_enabled:
			bar_enabled = true
			$BarPurchase.visible = true
		print("able to purchase\n")

func increment_muffins():
	$CoinPlayer.play()
	muffin_count += muffin_multiplier
	print("muffin count: ")
	print(muffin_count)
	print("\n")
	#if muffins more than 5 purchase option open
	if muffin_count >= 5:
		if !cream_enabled:
			cream_enabled = true
			$CreamPurchase.visible = true
		print("able to purchase\n")

func create_food():
	var choice = randi() % 2 == 0
	if choice:
		print("dochose")
		donut.process_mode = Node.PROCESS_MODE_INHERIT
		donut.visible = true
		muffin.process_mode = Node.PROCESS_MODE_DISABLED
		muffin.visible = false
		donut.position.x = donut_positionx
		donut.position.y = donut_positiony
	else:
		print("mufchose")
		muffin.process_mode = Node.PROCESS_MODE_INHERIT
		muffin.visible = true
		donut.process_mode = Node.PROCESS_MODE_DISABLED
		donut.visible = false
		muffin.position.x = muffin_positionx
		muffin.position.y = muffin_positiony
		
func donuts_to_bars() -> void:
	donut_count -= 5
	bar_count += 1
	print("bar count: ")
	print(bar_count)
	
	#check if cherries purchasable
	if bar_count >= 5:
		if !cherry_enabled:
			cherry_enabled = true
			$CherryPurchase.visible = true
	#check if donut_speed boost can be bought
	pass
	
func muffins_to_icecream() -> void:
	muffin_count -= 5
	cream_count += 1
	print("icecream count: ")
	print(cream_count)

	# check grape_purchase option
	if cream_count >= 5:
		if !grape_enabled:
			grape_enabled = true
			print("grape purchase available\n")
			$GrapePurchase.visible = true
	#check muff_speedboost
	pass

func bars_to_cherries() -> void:
	bar_count -= 5
	cherry_count += 1
	print("cherry bought with bar\n")
	# check if multiplier can be bought
	if cherry_count >= 1:
		if !donut_mult_enabled:
			donut_speed_enabled = true
			donut_mult_enabled = true
			$DonutMultiplier.visible = true
			$DonutSpeed.visible = true
	if cherry_count >= 3:
		if !scene2_enabled:
			scene2_enabled = true
			$Scene2.visible = true
			$Scene1.visible = true
	pass
	
func cream_to_grapes() -> void:
	cream_count -= 5
	grape_count += 1
	print("grape bought with cream")
	if grape_count >= 1:
		if !muffin_mult_enabled:
			muffin_speed_enabled = true
			muffin_mult_enabled = true
			$MuffinMultiplier.visible = true
			$MuffinSpeed.visible = true
	if grape_count >= 3:
		if !scene3_enabled:
			scene3_enabled = true
			$Scene3.visible = true
			$Scene1.visible = true
	# check if multiplier can be bought
	pass
	
