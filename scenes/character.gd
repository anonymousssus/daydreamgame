extends CharacterBody2D



const SPEED = 150
const JUMP_VELOCITY = -400
@onready var selfchar = get_node(".")

var lives = 3




func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_area_2d_body_exited(body: Node2D) -> void:
	lives = lives - 1
	get_node("./Camera2D/Heart" + str(lives)).visible = false
	global_position=Vector2(0,-3.0)
	selfchar.position = global_position
	


func _on_spike_body_entered(body: Node2D) -> void:
	if str(get_node(body.get_path())) == str(get_node('.')):
		lives = lives - 1
		get_node("./Camera2D/Heart" + str(lives)).visible = false
	else:
		pass


func _on_enemy_body_entered(body: Node) -> void:
	if str(get_node(body.get_path())) == str(get_node('.')):
		lives = lives - 1
		get_node("./Camera2D/Heart" + str(lives)).visible = false
	else:
		pass


func _process(delta: float) -> void:
	if lives == 0:
		get_tree().change_scene_to_file("res://scenes/gameover.tscn")
	else:
		pass
