extends Node2D

export(int) var max_hp = 10
var cur_hp setget set_cur_hp
export(int) var speed = 5

signal anim_strike
signal anim_end
signal anim_gothit_end
signal got_koed

func _ready():
	get_node("UI/VBoxContainer/TextureProgress").set_max(max_hp)
	set_cur_hp(max_hp)

func _got_koed():
	play("KO'ed")

func gothit_end():
	if cur_hp > 0:
		emit_signal("anim_gothit_end")
	else:
		emit_signal("got_koed")

func play(s):
	get_node("AnimationPlayer").play(s)

func set_cur_hp(v):
	cur_hp = v
	
	# UPDATE HP BAR
	get_node("UI/VBoxContainer/TextureProgress").set_value(cur_hp)

func take_damage(p):
	# INPUT: POWER
	set_cur_hp(cur_hp - p)
	get_node("DamageCounter/Label").set_text(String(p))
	play("Getting Hit")
