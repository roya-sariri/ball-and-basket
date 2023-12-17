extends Sprite2D

@onready var global = get_node("/root/Global")
var temp_color_lst = []


func _ready():
	temp_color_lst = global.color_lst.duplicate(true)
	for item in global.remaining_color_lst:
		temp_color_lst.erase(item)
	randomize_image()

func randomize_image():
	var index = randi() % temp_color_lst.size()
	self.modulate = temp_color_lst[index]
