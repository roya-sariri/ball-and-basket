extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	TextureButton.pressed.connect(x)

func x():
	print(1)
