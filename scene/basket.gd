extends Node2D

var images = [] # لیست عکس‌ها را در اینجا ذخیره کنید

func _ready():
	choose_random_image_for_each_basket()

func choose_random_image_for_each_basket():
		# اضافه کردن تمام عکس‌ها به لیست
	images.append(preload("res://sprite/basket/pink_basket.png"))
	images.append(preload("res://sprite/basket/yellow_basket.png"))
	images.append(preload("res://sprite/basket/orange_basket.png"))
	images.append(preload("res://sprite/basket/purple_basket.png"))
	images.append(preload("res://sprite/basket/blue_basket.png"))
	images.append(preload("res://sprite/basket/green_basket.png"))
	# تنظیم تصادفی عکس برای هر اسپرایت
	for i in range(get_child_count()):
		var texture_button = get_child(i)
		randomize_image(texture_button)

func randomize_image(texture_button):
	if images.size() == 0:
		print("لیست عکس‌ها خالی است!")
		return

	var index = randi() % images.size()
	texture_button.set_texture_normal(images[index])
	images.remove_at(index)	
