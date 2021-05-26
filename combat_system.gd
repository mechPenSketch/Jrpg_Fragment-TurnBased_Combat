extends Node

enum {COMMAND, ACTION, FLEE}
var current_state = COMMAND

var current_round
var queue = []
var current_turn

func _on_command_pressed():
	change_state(ACTION)

func _on_flee_pressed():
	change_state(FLEE)

func activate_state():
	match current_state:
		COMMAND:
			get_node("Control").show()
	
func change_state(new_state):
	deactivate_state()
	current_state = new_state
	activate_state()
	
func deactivate_state():
	match current_state:
		COMMAND:
			get_node("Control").hide()

func sort_by_speed(a, b):
	return a.speed > b.speed
