extends Node2D

var countdown : int = 3  # عدد ابتدایی
var countdown_timer : Timer
var ball_scene = load("res://scene/ball.tscn")
var basket_scene = load("res://scene/basket.tscn")
var instance_ball_scene = ball_scene.instantiate()
var instance_basket_scene = basket_scene.instantiate()

func _ready():
	$Panel3.hide()
	_create_time()
	add_child(instance_ball_scene)
	add_child(instance_basket_scene)

	for i in range(instance_basket_scene.get_child_count()):
		var texture_button = instance_basket_scene.get_child(i)
		texture_button.pressed.connect(_on_button_pressed.bind(texture_button, instance_ball_scene.get_child(0)))

func _on_button_pressed(basket, ball):
	var basket_color = basket.texture_normal.resource_path.get_file().split("_")[0]
	var ball_color = ball.texture.resource_path.get_file().split("_")[0]
	if basket_color == ball_color:
		set_level_game()
		var level = $Panel2.get_node("level_number_label").text.to_int() + 1
		$Panel2.get_node("level_number_label").set_text(str(level))

func _choose_ball_and_basket_random_image():
	var script2d_ball = instance_ball_scene.get_node("Sprite2D")
	script2d_ball.randomize_image()
	instance_basket_scene.choose_random_image_for_each_basket()

func _create_time():
	countdown_timer = Timer.new()
	add_child(countdown_timer)
	countdown_timer.connect("timeout", _on_timer_timeout)
	countdown_timer.start()

func _on_timer_timeout():
	countdown -= 1
	var remaining_time = $Panel1.get_node("time_number_label").text.to_int() - 1
	$Panel1.get_node("time_number_label").set_text(str(remaining_time))
	if $Panel1.get_node("time_number_label").text.to_int() <= 0:
		$Panel3.show()
		enabel_disable_basket_button(true)
		await get_tree().create_timer(1).timeout 
		$Panel3.hide()
		enabel_disable_basket_button(false)
		set_level_game()
	else:
		countdown_timer.start()  # شروع تایمر مجدداً برای یک ثانیه دیگر
		$Panel3.hide()

func set_level_game():
	var point = 0
	if $Panel.get_node("point_number_label").text.to_int() != 0:
		point = $Panel.get_node("point_number_label").text.to_int() - 1
	else:
		point = $Panel.get_node("point_number_label").text.to_int() + 1
	$Panel.get_node("point_number_label").set_text(str(point))
	_choose_ball_and_basket_random_image()
	$Panel1.get_node("time_number_label").set_text(str(3))
	countdown_timer.stop()
	_create_time()

func enabel_disable_basket_button(state):
	for i in range(instance_basket_scene.get_child_count()):
		var texture_button = instance_basket_scene.get_child(i)
		texture_button.set_disabled(state)
