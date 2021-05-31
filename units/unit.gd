extends Node2D

export(int) var max_hp = 10
var cur_hp
export(int) var speed = 5

func _ready():
	cur_hp = max_hp

func play(s):
	get_node("AnimationPlayer").play(s)
