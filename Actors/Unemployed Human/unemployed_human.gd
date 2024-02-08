## Basic human node. Can speak and move by default. 
@tool
class_name UNEMPLOYED_HUMAN extends CharacterBody2D

@export var Name : String		## Name of Character. 

## These notes can just be %references to the nodes in the tree, but this way, you always know if they aren't connected. 
@export_group("Nodes")
@export var inputNode : INPUT			## Human's input node. 
@export var velocityNode : VELOCITY		## Human's velocity node. 
@export var speakNode : SPEAK			## Human's speech node. 
@export var inventory : INVENTORY		## Human's inventory node. 

@export_group("Movement")
@export var sprintModifier : float = 1.5	## Sprint modifier value. 

var addMods : Array[float] = []		## Any + modifiers to speed. 
var multMods : Array[float] = []	## Any * modifiers to speed. 

#/
## Idle frame processing. Contains non-movement based inputs. 
func _process(_delta):
	if Engine.is_editor_hint():
		return
		
	## Handle non-movement inputs ##
	speakNode.handleSpeakInput()
	
#/
## The main processing function of the human node. 
func _physics_process(delta):
	## Sync sprite's position with the node ##
	## NOTE: this could be done in the Sprite2D node itself, OR make "Appearance" be a Node2D. 
	$Appearance/Sprite2D.position = self.position
	
	if Engine.is_editor_hint():
		return
	
	## Clear all mods ##
	addMods = []
	multMods = []
	
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


#/
## This function handles a new piece of mail. 
func receiveMail(newMail : MAIL) -> bool:
	## TODO: NPCs will just thank you for their mail instead of adding to their inventory
	## NOTE: "Mail Reception" could be its own module, or this could go straight to inventory. 
	return inventory.addMail(newMail)
