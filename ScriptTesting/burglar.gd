extends CharacterBody2D

# Signal gets sent out when a player collides with an enemy

@export var speed = 50.0
@onready var burglar_mob_interactions: Area2D = $BurglarMobInteractions
@onready var game: Node = $".."

# continuosly gets input for direction
func get_input():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y): # Horizontal movement
			if direction.x > 0:
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("left_right")
			else:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("left_right")
		else: # Vertical Movement
			if direction.y > 0:
				$AnimatedSprite2D.play("forward")
			else:
				$AnimatedSprite2D.play("back")
	else:
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.stop()


func _physics_process(_delta):
	get_input()
	move_and_slide()

# Works as collission detection when the guard enters the hitbox for the burglar	
func _on_burglar_mob_interactions_body_entered(body: Node2D) -> void:
	if body.is_in_group("Guard"):
		print("Guard detected, choosing an action")
		var n: int = randi() % 2
		# Chooses a random action to do
		if n == 1: 
			game.remove_point()
		else:
			game.remove_time()
			
				
			
