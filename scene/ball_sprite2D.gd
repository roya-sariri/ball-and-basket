extends Sprite2D

var images = [] # لیست عکس‌ها را در اینجا ذخیره کنید

func _ready():
	# اضافه کردن عکس‌ها به لیست
	images.append(load("res://sprite/ball/pink_ball.png"))
	images.append(load("res://sprite/ball/yellow_ball.png"))
	images.append(load("res://sprite/ball/orange_ball.png"))
	images.append(load("res://sprite/ball/purple_ball.png"))
	images.append(load("res://sprite/ball/blue_ball.png"))
	images.append(load("res://sprite/ball/green_ball.png"))
	
	# انتخاب تصادفی یک عکس و تنظیم آن برای گره "Sprite"
	randomize_image()

func randomize_image():
	var index = randi() % images.size()
	texture = images[index]
