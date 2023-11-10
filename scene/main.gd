extends Sprite2D


@export var ball_scene = load("res://scene/ball.tscn")
@export var basket_scene = load("res://scene/basket.tscn")

func _ready():
	var instance_ball_scene = ball_scene.instantiate()
	var instance_basket_scene = basket_scene.instantiate()
	add_child(instance_ball_scene)
	add_child(instance_basket_scene)

	for i in range(instance_basket_scene.get_child_count()):
		var texture_button = instance_basket_scene.get_child(i)
		texture_button.pressed.connect(_on_button_pressed.bind(texture_button, instance_ball_scene.get_child(0)))

func _on_button_pressed(basket, ball):
	var basket_color = basket.texture_normal.resource_path.get_file().split("_")[0]
	var ball_color = ball.texture.resource_path.get_file().split("_")[0]
	if basket_color == ball_color:
		print("yes")
