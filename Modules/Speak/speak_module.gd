## This is a basic speech module that can be attached to actors' scenes. 
## Realistically, this could be linked to a dialogue or quest system!
class_name SPEAK extends Node

@export_group("Nodes")
@export var individual : CharacterBody2D	## Parent node that does any movement. 

#/
## Determine if the character should speak. 
func handleSpeakInput(): 
	if Input.is_action_just_pressed("ui_speak"):
		print("My name is: " + individual.Name)
		
