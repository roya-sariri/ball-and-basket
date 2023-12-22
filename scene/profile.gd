extends Node2D


func _ready():
	if not $Panel.get_node("name_label").text:
		var name = randf_range(0, 1000)
		$Panel.get_node("name_label").set_text(str(name))
	$exit_texture_button.pressed.connect(go_to_main)
	var global = get_node("/root/Global")
	change_value_point(str(global.save_dict["point"]))

func go_to_main():
	get_tree().change_scene_to_file('res://Scene/main.tscn')

func change_value_point(value):
	$Panel.get_node("point_label").set_text(str(value))
