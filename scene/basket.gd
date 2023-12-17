extends Node2D

@onready var global = get_node("/root/Global")

func _ready():
	choose_random_image_for_each_basket()

func choose_random_image_for_each_basket():
	global.remaining_color_lst = global.color_lst.duplicate(true)
	for child in get_children():
		if child is TextureButton:
			randomize_image(child)

func randomize_image(texture_button):
	var index = randi() % global.remaining_color_lst.size()
	texture_button.modulate = global.remaining_color_lst[index]
	global.remaining_color_lst.remove_at(index)
