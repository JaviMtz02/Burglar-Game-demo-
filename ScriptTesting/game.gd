extends Node
@onready var loot_count: Label = $CanvasLayer/LootCount
@onready var time: Label = $CanvasLayer/Time
@export var score = 0
@onready var timer: Timer = $Timer
@onready var coins: Node = $Coins
@export var max_score: int
@onready var burglar: CharacterBody2D = $Burglar

var time_seconds: int = 60
var time_minutes: int = 0
var start_time = 0
var running: bool = false

func _ready():
	max_score = coins.get_children().size()
	timer.wait_time = 1.0
	timer.one_shot = false # We want the timer to repeat and not let this be a one time thing
	timer.start()

func _process(_delta):
		if running: 
			var elapsed_time = Time.get_unix_time_from_system() - start_time
			var _remaining_time = 5 - elapsed_time
			burglar.speed = 100.0
	
			if elapsed_time >= 5:
				running = false
				burglar.speed = 50.0
	
func add_point():
	score += 1
	loot_count.text = "Loot: " + str(score)
	

func remove_point():
	if(score > 0):
		score -= 1
		loot_count.text = "Loot: " + str(score)

# Once Timer reaches zero I go to the end screen
# Transfer variables from this scene to the end scene to appropriately get total
func _on_timer_timeout() -> void:
	if time_seconds > 0:
		time_seconds -= 1
	else:
		if time_minutes > 0:
			time_minutes -= 1
			time_seconds = 59
	
	var formatted_time = str(time_minutes) + ":" + str(time_seconds)
	time.text = formatted_time
	
	if time_minutes == 0 and time_seconds == 0:
		timer.stop()
		
		var end_screen = preload("res://Scenes/end_screen.tscn").instantiate()
		end_screen.score = score
		end_screen.max_score = max_score
		get_tree().current_scene.queue_free()
		get_tree().root.add_child(end_screen)

# Whenever burglar bumps into a guard, it will either lose a point, or get time deducted
func remove_time():
	time_seconds -= randi() % 8

# Adds time to game when interactable is obtained
func add_time():
	time_seconds += randi() % 11

func start_countdown():
	start_time = Time.get_unix_time_from_system()
	running = true
	

	
		
