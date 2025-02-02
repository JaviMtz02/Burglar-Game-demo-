extends Control

var score = 0
var max_score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ScoreLabel.text = "Score: " + str(score)
	if score == max_score:
		$PerfectRun.show()
		$InPerfectRun.hide()
	else:
		$InPerfectRun.show()
		$PerfectRun.hide()
	
func _on_button_pressed() -> void:
	$ColorRect.hide()
	$Button.hide()
	$Label.hide()
	$ScoreLabel.hide()
	$PerfectRun.hide()
	$InPerfectRun.hide()
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
