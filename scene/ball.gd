extends Sprite2D

@onready var global = get_node("/root/Global")
var temp_color_lst = []


func _ready():
	randomize_image()

func randomize_image():
	create_ball_color_list_based_on_basket_color_list()
	var index = randi() % temp_color_lst.size()
	self.modulate = temp_color_lst[index]

func create_ball_color_list_based_on_basket_color_list():
	temp_color_lst = global.color_lst.duplicate(true)
	for item in global.remaining_color_lst:
		temp_color_lst.erase(item)
