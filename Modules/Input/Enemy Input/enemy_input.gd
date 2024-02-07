## This node handles inputs for enemies. Currently, input is arbitrary, but it can be expanded
## or replaced with enemy-specific input modules. Ideally, these would be state machines and
## leverage things like player awareness Area2Ds, etc. 
extends INPUT

class_name ENEMY_INPUT

func handleMoveInputs(delta):
	moveInput = randf_range(-1.0, 1.0)
	jumpInput = randi() % 2
