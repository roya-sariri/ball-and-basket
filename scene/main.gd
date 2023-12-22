extends Node2D

@onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D3.modulate = Color(0.7, 1, 0.1)
	$Sprite2D2.modulate = Color(0.78, 0.85, 11)
	$Popup.hide()
	$new_button.pressed.connect(check_befor_go_new_game)
	$load_button.pressed.connect(go_to_load_game)
	$exit_button.pressed.connect(go_to_exit)
	$profile_texture_button.pressed.connect(go_to_profile)
	read_from_json_file_and_set_it_in_save_dict()

func read_from_json_file_and_set_it_in_save_dict():
	if FileAccess.file_exists(global.save_loacation):
		var file = FileAccess.open(global.save_loacation, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		global.save_dict = test_json_conv.get_data()
		file.close()

func check_befor_go_new_game():
	if FileAccess.file_exists(global.save_loacation):
		$Popup.show()
		get_tree().set_pause(!get_tree().is_paused())
		$Popup.get_node("ok_button").pressed.connect(go_to_new_game)
		$Popup.get_node("cancel_button").pressed.connect(cancel_exit)
	else:
		get_tree().change_scene_to_file('res://Scene/game.tscn')

func go_to_new_game():
	get_tree().set_pause(!get_tree().is_paused())
	global.save_dict["point"] = 0
	global.save_dict["level"] = 1
	global.save_dict["heart"] = 3
	get_tree().change_scene_to_file('res://Scene/game.tscn')

func cancel_exit():
	get_tree().set_pause(!get_tree().is_paused())
	$Popup.hide()

func go_to_load_game():
	if FileAccess.file_exists(global.save_loacation):
		var file = FileAccess.open(global.save_loacation, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		global.save_dict = test_json_conv.get_data()
		file.close()
	get_tree().change_scene_to_file('res://Scene/game.tscn')

func go_to_exit():
	get_tree().quit()

func go_to_profile():
	get_tree().change_scene_to_file('res://Scene/profile.tscn')
