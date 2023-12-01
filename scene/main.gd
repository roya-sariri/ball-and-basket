extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$new_button.pressed.connect(go_to_new_game)
	$load_button.pressed.connect(go_to_load_game)
	$exit_button.pressed.connect(go_to_exit)
	$profile_texture_button.pressed.connect(go_to_profile)

func go_to_new_game():
	get_tree().change_scene_to_file('res://Scene/game.tscn')

func go_to_load_game():
	var game_scene = load("res://scene/game.tscn")
	var instance_game_scene = game_scene.instantiate()
	if FileAccess.file_exists(instance_game_scene.save_loacation):
		var file = FileAccess.open(instance_game_scene.save_loacation, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		var global = get_node("/root/Global")
		global.save_dict = test_json_conv.get_data()
		file.close()
	get_tree().change_scene_to_file('res://Scene/game.tscn')

func go_to_exit():
	get_tree().quit()

func go_to_profile():
	get_tree().change_scene_to_file('res://Scene/profile.tscn')
