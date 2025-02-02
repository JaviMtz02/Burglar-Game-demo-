extends CharacterBody2D

@export var speed = 25.0
@onready var navigation_region: NavigationRegion2D = $"../NavigationRegion2D"
@onready var detector: RayCast2D = $RayCast2D
@onready var burglar: CharacterBody2D = $"../../Burglar"
@onready var light: PointLight2D = $RayCast2D/PointLight2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var target_pos: Vector2
var is_following_burglar: bool = false

func _ready():
	pick_new_target()

func set_target_position(target: Vector2):
	target_pos = target
	$NavigationAgent2D.target_position = target

func _physics_process(_delta):
	if $NavigationAgent2D.is_navigation_finished():
		pick_new_target()
		
	var next_path_point = $NavigationAgent2D.get_next_path_position()
	var direction = (next_path_point - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	update_detector(direction)
	update_animation(direction)
	if is_following_burglar:
		follow_burglar()

func pick_new_target():
	# Need to dynamically change target direction according to screen and map type!
	var new_target = Vector2(randi_range(100,1100), randi_range(100, 600))
	set_target_position(new_target)
	
func update_animation(direction: Vector2):
	if direction.length() == 0:
		# No movement, means its just standing still
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.stop()
	
	# Choosing dominant direction for animations	
	var abs_x = abs(direction.x)
	var abs_y = abs(direction.y)
	
	if abs_x > abs_y:
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("left_right")
		else:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("left_right")
	else:
		if direction.y > 0:
			$AnimatedSprite2D.play("forward")
		else:
			$AnimatedSprite2D.play("back")

func update_detector(direction: Vector2):
	if direction.length() == 0:
		return
	direction = direction.normalized()
	detector.target_position = direction * 75 # Adjust the RayCast 2D according to direction guard is walking
	light.position = detector.position
	light.rotation = direction.angle()
	light.scale.y = 75 / 100.0
	
	if detector.is_colliding():
		var collider = detector.get_collider()
		if collider == burglar: # So if the raycast has detected the burglar, it starts to follow it
			is_following_burglar = true
	else:
		if is_following_burglar:
			is_following_burglar = false
			
	
func follow_burglar():
	target_pos = burglar.global_position
	$NavigationAgent2D.target_position = target_pos
	var direction = (target_pos - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Guard") and body != self:
		collision_shape_2d.set_deferred("disabled", true)

#func _on_area_2d_body_exited(body: Node2D) -> void:
		#collision_shape_2d.set_deferred("disabled", false)
