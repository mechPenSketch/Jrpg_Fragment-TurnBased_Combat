extends Node

enum {COMMAND, ACTION, FLEE}
var current_state = COMMAND

var current_round
var queue = []
var current_turn

func _on_command_pressed(cmd):
	# PLAYER'S COMMAND
	var new_dict = {
		"user": get_node("Units/Allies/Alice"),
		"power": cmd.power,
		"target": get_node("Units/Enemies/Enemy")
	}
	queue.append(new_dict)
	
	# ENEMIES COMMAND
	var new_emy_dict = {
		"user": get_node("Units/Enemies/Enemy"),
		"power": cmd.power,
		"target": get_node("Units/Allies/Alice")
	}
	queue.append(new_emy_dict)
	
	# SORT QUEUE
	queue.sort_custom(self, "sort_by_speed")
	
	# CHANGE STATE
	change_state(ACTION)

func _on_flee_pressed():
	change_state(FLEE)

func _on_unit_getting_hit_end():
	# ONTO NEXT TURN
	current_turn += 1
	activate_turn()
	
func _on_unit_strike():
	queue[current_turn]["target"].play("Getting Hit")

func activate_state():
	match current_state:
		COMMAND:
			get_node("Control").show()
		ACTION:
			current_turn = 0
			activate_turn()

func activate_turn():
	if current_turn < queue.size():
		queue[current_turn]["user"].play("Attack")
	else:
		change_state(COMMAND)

func change_state(new_state):
	deactivate_state()
	current_state = new_state
	activate_state()
	
func deactivate_state():
	match current_state:
		COMMAND:
			get_node("Control").hide()
		ACTION:
			queue = []

func sort_by_speed(a, b):
	return a["user"].speed > b["user"].speed
