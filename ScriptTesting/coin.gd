extends Area2D

@onready var game: Node = $"../.."
@onready var burglar: CharacterBody2D = $"../../Burglar"

func _ready():
	$AnimatedSprite2D.play("default")
	
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body == burglar:
			game.add_point()
			queue_free()
