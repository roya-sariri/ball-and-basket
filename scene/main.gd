extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$new_button.pressed.connect(go_to_new_game)
	$exit_button.pressed.connect(go_to_exit)

func go_to_new_game():
	get_tree().change_scene_to_file('res://Scene/game.tscn')

func go_to_exit():
	get_tree().quit()
