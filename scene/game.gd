extends Node2D


var ball_scene = load("res://scene/ball.tscn")
var basket_scene = load("res://scene/basket.tscn")
var instance_ball_scene = ball_scene.instantiate()
var instance_basket_scene = basket_scene.instantiate()

func _ready():
	add_child(instance_ball_scene)
	add_child(instance_basket_scene)

	for i in range(instance_basket_scene.get_child_count()):
		var texture_button = instance_basket_scene.get_child(i)
		texture_button.pressed.connect(_on_button_pressed.bind(texture_button, instance_ball_scene.get_child(0)))

func _on_button_pressed(basket, ball):
	var basket_color = basket.texture_normal.resource_path.get_file().split("_")[0]
	var ball_color = ball.texture.resource_path.get_file().split("_")[0]
	if basket_color == ball_color:
		var extra_point = $point_number_label.text.to_int() + 1
		$point_number_label.set_text(str(extra_point))
		var script2d_ball = instance_ball_scene.get_node("Sprite2D")
		script2d_ball.randomize_image()
		instance_basket_scene.choose_random_image_for_each_basket()
