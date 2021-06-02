extends Node2D

export(int) var max_hp = 10
var cur_hp setget set_cur_hp
export(int) var speed = 5

signal anim_strike
signal anim_end

func _ready():
	get_node("UI/VBoxContainer/TextureProgress").set_max(max_hp)
	cur_hp = max_hp

func play(s):
	get_node("AnimationPlayer").play(s)

func set_cur_hp(v):
	cur_hp = v
	
	# UPDATE HP BAR
	get_node("UI/VBoxContainer/TextureProgress").set_value(cur_hp)
