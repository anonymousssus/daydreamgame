extends CharacterBody2D



@export var speed = 75
@onready var player = get_parent().get_node("character")

func _physics_process(delta):
	if player:
		# Calculate the direction to the player
		var direction = position.direction_to(player.position)

		# Set the velocity and move
		velocity = direction * speed
		move_and_slide()
