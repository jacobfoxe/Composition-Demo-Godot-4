## Basic human node. Can speak and move by default. 
class_name HUMAN extends CharacterBody2D

@export var Name : String

## These notes can just be %references to the nodes in the tree, but this way, you always know if they aren't connected. 
@export_group("Nodes")
@export var inputNode : INPUT
@export var velocityNode : VELOCITY
@export var speakNode : SPEAK
@export var inventory : INVENTORY

@export_group("Movement")
@export var sprintModifier : float = 1.5

#/
## The main processing function of the human node. 
func _physics_process(delta):
	var addMods : Array[float] = []
	var multMods : Array[float] = []
	
	## Get move inputs ##
	inputNode.handleMoveInputs(delta)
	
	## If we're running, add the sprintModifier to the speedMods ##
	if inputNode.runInput:
		multMods.push_back(sprintModifier)
	
	## Add in speed calculations ##
	velocityNode.calculateSpeed(addMods, multMods)
	
	## Handle velocity calculations ##
	velocityNode.handleVelocity(delta)
	
	## Move! ##
	velocityNode.activateMove()

	## Handle non-movement inputs ##
	speakNode.handleSpeakInput()


func receiveMail(newMail : MAIL) -> bool:
	## TODO: NPCs will just thank you for their mail instead of adding to their inventory
	## NOTE: "Mail Reception" could be its own module, or this could go straight to inventory. 
	return inventory.addMail(newMail)
