extends Control
@onready var instructions: Label = $Instructions
@onready var start_button: Button = $StartButton
@onready var game_title: Label = $GameTitle
@onready var instructions_button: Button = $InstructionsButton
@onready var credits: Label = $Credits
@onready var back_button: Button = $BackButton

func _ready() -> void:
	instructions.hide()
	credits.hide()
	back_button.hide()
	
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_instructions_button_pressed() -> void:
	instructions.show()
	credits.show()
	back_button.show()
	game_title.hide()
	instructions_button.hide()
	start_button.hide()


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
