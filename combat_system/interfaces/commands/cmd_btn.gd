extends Button

var power = 5

func _ready():
	connect("pressed", get_node("/root/Combat"), "_on_command_pressed", [self])
