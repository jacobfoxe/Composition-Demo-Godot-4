extends Node2D

class_name VELOCITY

@export var SPEED : float = 300.0
@export var JUMP_VELOCITY : float = -400.0

@export_group("Nodes")
@export var individual : CharacterBody2D	# Parent node that does any movement. 
@export var inputNode : INPUT	# Grab the parent's input node.

var currentSpeed : float = SPEED

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#/
## Handle any velocity calculations. 
func handleVelocity(delta):
	# Add the gravity.
	if not individual.is_on_floor():
		individual.velocity.y += gravity * delta

	# Handle jump.
	if inputNode.getJumpInput() and individual.is_on_floor():
		individual.velocity.y = JUMP_VELOCITY

	## NOTE: If Sprinting is STANDARD for all users of this module, it could be moved here.
	
	# Get the input direction and handle the movement/deceleration.
	var direction = inputNode.getMoveInput()
	if direction:
		individual.velocity.x = direction * currentSpeed
	else:
		individual.velocity.x = move_toward(individual.velocity.x, 0, SPEED)

#/
## Call any movement-related functions to initiate movement. 
func activateMove():
	individual.move_and_slide()

#/
## Modify the speed for any given set of modifiers. 
func calculateSpeed(addModifiers : Array[float], multModifiers : Array[float]):
	currentSpeed = SPEED
	
	## Add all multipliers first ##
	for modifier in addModifiers:
		currentSpeed += modifier
	
	## Multiply last (to make sure things like slows work properly) ##
	for modifier in multModifiers:
		currentSpeed *= modifier

