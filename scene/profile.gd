extends Node2D

@onready var global = get_node("/root/Global")

func _ready():
	if not $Panel.get_node("name_label").text:
		var name = randf_range(0, 1000)
		$Panel.get_node("name_label").set_text(str(name))
	$Panel.get_node("point_label").set_text(str(global.save_dict["point"]))
	$exit_texture_button.pressed.connect(go_to_main)

func go_to_main():
	get_tree().change_scene_to_file('res://Scene/main.tscn')
