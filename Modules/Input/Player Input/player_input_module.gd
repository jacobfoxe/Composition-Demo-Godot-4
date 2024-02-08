## This is a player-focused input node that inherits from base INPUT class. 
class_name PLAYER_INPUT extends INPUT

var runInput : bool		# Detect if the player is running. 

func handleMoveInputs(delta):
	moveInput = Input.get_axis("ui_left", "ui_right")
	jumpInput = Input.is_action_just_pressed("ui_accept")
	runInput = Input.is_action_pressed("ui_sprint")
