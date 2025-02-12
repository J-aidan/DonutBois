extends CharacterBody2D

@onready var donut_sprite = $Sprite2D

const JUMP_VELOCITY = 0.0

var SPEED = 100.0

var direction = 0.0

var moved = false

var saved_direction = 0.0



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	#allow only one click
	var direction = Input.get_axis("ui_left", "ui_right")
	if(!moved):
		if direction:
			moved = true
			saved_direction = direction
	if moved:
		velocity.x = saved_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body != self and body.name != "Muffin":
		var game_controller = get_tree().root.get_node("GameScene")
		direction = 0.0
		saved_direction = 0.0
		moved = false
		print("entered" + body.name)
		if body.name == "Animal1":
			#bunny eat
			var animated_sprite = get_tree().root.get_node("GameScene/Animal1/AnimatedSprite2D")
			animated_sprite.animation = "eat"
			
			#update counts
			game_controller.increment_donuts()
			
			donut_sprite.visible = false
			
			#wait
			await get_tree().create_timer(1.0).timeout
			donut_sprite.visible = true
			animated_sprite.animation = "idle"
		
		game_controller.create_food()
			
	pass # Replace with function body.
