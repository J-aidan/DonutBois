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
var bar_multiplier :=1

var cream_count := 0
var cream_multiplier := 1

var cherry_count := 0
var cherry_multiplier :=1

var grape_count := 0
var grape_multiplier := 1

var donut_node
var muffin_node

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
	
	# check if any buttons pressed
	if $CreamPurchase.is_pressed():
		print("Cream was pressed")
		muffins_to_icecream()
		$CreamPurchase.set_disabled(true)
		$CreamPurchase.set_pressed(false)
	if $BarPurchase.is_pressed():
		print("Bar was pressed")
		donuts_to_bars()
		$BarPurchase.set_disabled(true)
		$BarPurchase.set_pressed(false)
	if $CherryPurchase.is_pressed():
		print("Cherry was pressed")
		bars_to_cherries()
		$CherryPurchase.set_disabled(true)
		$CherryPurchase.set_pressed(false)
	if $GrapePurchase.is_pressed():
		print("Grape was pressed")
		cream_to_grapes()
		$GrapePurchase.set_disabled(true)
		$GrapePurchase.set_pressed(false)
	if $MuffinMultiplier.is_pressed():
		print("Muffin multiplies\n")
		muffin_multiplier += 1
		$MuffinMultiplier.set_disabled(true)
		$MuffinMultiplier.set_pressed(false)
	$MuffinSpeed.visible = true
	$MuffinSpeed.set_disabled(false)
	if $MuffinSpeed.is_pressed():
		print("increase muffin speed\n")
		muffin_node.SPEED += 100
		$MuffinSpeed.set_pressed(false)
		$MuffinSpeed.set_disabled(true)
	if $DonutMultiplier.is_pressed():
		print("Donut multiplies\n")
		donut_multiplier += 1
		$DonutMultiplier.set_disabled(true)
		$DonutMultiplier.set_pressed(false)
	$DonutSpeed.visible = true
	$DonutSpeed.set_disabled(false)
	if $DonutSpeed.is_pressed():
		print("Donut speed increases\n")
		donut_node.SPEED += 100
		$DonutSpeed.set_disabled(true)
		$DonutSpeed.set_pressed(false)
	pass

func increment_donuts():
	$CoinPlayer.play()
	donut_count += donut_multiplier
	print("donut count: ")
	print(donut_count)
	print("\n")
	#if donuts more than 5 purchase option open
	if donut_count >= 5:
		$BarPurchase.visible = true
		$BarPurchase.set_disabled(false)
		print("able to purchase\n")

func increment_muffins():
	$CoinPlayer.play()
	muffin_count += muffin_multiplier
	print("muffin count: ")
	print(muffin_count)
	print("\n")
	#if muffins more than 5 purchase option open
	if muffin_count >= 5:
		$CreamPurchase.visible = true
		$CreamPurchase.set_disabled(false)
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
	$BarPurchase/BarLabel.text = str(bar_count)
	
	#check if cherries purchasable
	if bar_count >= 5:
		$CherryPurchase.visible = true
		$CherryPurchase.set_disabled(false)
		$DonutSpeed.visible = true
		$DonutSpeed.set_disabled(false)
	#check if donut_speed boost can be bought
	pass
	
func muffins_to_icecream() -> void:
	muffin_count -= 5
	cream_count += 1
	print("icecream count: ")
	print(cream_count)
	$CreamPurchase/CreamLabel.text = str(cream_count)

	# check grape_purchase option
	if cream_count >= 5:
		print("grape purchase available\n")
		$GrapePurchase.visible = true
		$GrapePurchase.set_disabled(false)
		$MuffinSpeed.visible = true
		$MuffinSpeed.set_disabled(false)
	#check muff_speedboost
	pass

func bars_to_cherries() -> void:
	bar_count -= 5
	cherry_count += 1
	$CherryPurchase/CherryLabel.text = str(cherry_count)
	print("cherry bought with bar\n")
	# check if multiplier can be bought
	if cherry_count >= 1:
		$DonutMultiplier.visible = true
		$DonutMultiplier.set_disabled(false)
	pass
	
func cream_to_grapes() -> void:
	cream_count -= 5
	grape_count += 1
	$GrapePurchase/GrapeLabel.text = str(grape_count)
	print("grape bought with cream")
	if grape_count >= 1:
		$MuffinMultiplier.visible = true
		$MuffinMultiplier.set_disabled(false)
	# check if multiplier can be bought
	pass
	
