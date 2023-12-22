extends Node2D

var countdown : int = 3
var countdown_timer : Timer

var main_scene = load("res://scene/main.tscn")
var basket_scene = load("res://scene/basket.tscn")
var ball_scene = load("res://scene/ball.tscn")
var profile_scene = load("res://scene/profile.tscn")

var instance_main_scene = main_scene.instantiate()
var instance_basket_scene = basket_scene.instantiate()
var instance_ball_scene = ball_scene.instantiate()
var instance_profile_scene = profile_scene.instantiate()

@onready var global = get_node("/root/Global")

func _ready():
	$Panel2.get_node("level_number_label").set_text(str(global.save_dict["level"]))
	$Panel.get_node("point_number_label").set_text(str(global.save_dict["point"]))
	$Panel.get_node("heart_number_label").set_text(str(global.save_dict["heart"]))
	$Panel3.hide()
	$Popup.hide()
	$exit_texture_button.pressed.connect(exit)
	create_time()
	add_child(instance_basket_scene)
	add_child(instance_ball_scene)

	for i in range(instance_basket_scene.get_child_count()):
		var texture_button = instance_basket_scene.get_child(i)
		texture_button.pressed.connect(_on_button_pressed.bind(texture_button, instance_ball_scene.get_child(0)))

func _on_button_pressed(basket, ball):
	if basket.modulate == ball.modulate:
		$Panel3.get_node("message_label").set_text("Correct")
		$Panel3.show()
		var point = $Panel.get_node("point_number_label").text.to_int() + 1
		set_point(str(point))
		var level = $Panel2.get_node("level_number_label").text.to_int() + 1
		set_level(str(level))
	else:
		$Panel3.get_node("message_label").set_text("Wrong")
		$Panel3.show()
		reduce_heart()
	set_new_level_game()
	save_file()

func choose_ball_and_basket_random_image():
	var script2d_ball = instance_ball_scene.get_node("Sprite2D")
	instance_basket_scene.choose_random_image_for_each_basket()
	script2d_ball.randomize_image()

func create_time():
	countdown_timer = Timer.new()
	add_child(countdown_timer)
	countdown_timer.connect("timeout", on_timer_timeout)
	countdown_timer.start()

func on_timer_timeout():
	countdown -= 1
	var remaining_time = $Panel1.get_node("time_number_label").text.to_int() - 1
	$Panel1.get_node("time_number_label").set_text(str(remaining_time))
	if $Panel1.get_node("time_number_label").text.to_int() <= 0:
		$Panel3.get_node("message_label").set_text("Finish")
		$Panel3.show()
		enabel_disable_basket_button(true)
		await get_tree().create_timer(1).timeout
		$Panel3.hide()
		enabel_disable_basket_button(false)
		set_new_level_game()
		reduce_heart()
	else:
		countdown_timer.start()  # شروع تایمر مجدداً برای یک ثانیه دیگر
		$Panel3.hide()

func reduce_heart():
	var heart = $Panel.get_node("heart_number_label").text.to_int() - 1
	if heart != 0:
		set_heart(str(heart))
	elif heart == 0:
		set_level(str(1))
		set_heart(str(3))
	save_file()

func set_heart(text):
	$Panel.get_node("heart_number_label").set_text(text)
	global.save_dict["heart"] = $Panel.get_node("heart_number_label").text.to_int()

func set_level(text):
	$Panel2.get_node("level_number_label").set_text(text)	
	global.save_dict["level"] = $Panel2.get_node("level_number_label").text.to_int()

func set_point(text):
	$Panel.get_node("point_number_label").set_text(text)
	global.save_dict["point"] = $Panel.get_node("point_number_label").text.to_int()
	instance_profile_scene.change_value_point(global.save_dict["point"])

func set_new_level_game():
	choose_ball_and_basket_random_image()
	$Panel1.get_node("time_number_label").set_text(str(3))
	countdown_timer.stop()
	create_time()

func enabel_disable_basket_button(state):
	for i in range(instance_basket_scene.get_child_count()):
		var texture_button = instance_basket_scene.get_child(i)
		texture_button.set_disabled(state)

func exit():
	get_tree().set_pause(!get_tree().is_paused())
	$Popup.show()
	$Popup.get_node("ok_button").pressed.connect(go_to_main)
	$Popup.get_node("cancel_button").pressed.connect(cancel_exit)

func go_to_main():
	get_tree().set_pause(!get_tree().is_paused())
	get_tree().change_scene_to_file('res://Scene/main.tscn')

func cancel_exit():
	get_tree().set_pause(!get_tree().is_paused())
	$Popup.hide()

func save_file():
	var file = FileAccess.open(global.save_loacation, FileAccess.WRITE)
	file.store_string(JSON.new().stringify(global.save_dict))
	file.close()
