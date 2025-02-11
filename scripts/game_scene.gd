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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("start")
	MusicPlayer.play_bgm()
	create_food()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$DonutLabel.text = str(donut_count)
	$MuffinLabel.text = str(muffin_count)
	pass

func increment_donuts():
	$CoinPlayer.play()
	donut_count += donut_multiplier
	print("donut count: ")
	print(donut_count)
	print("\n")

func increment_muffins():
	$CoinPlayer.play()
	muffin_count += muffin_multiplier
	print("muffin count: ")
	print(muffin_count)
	print("\n")

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
