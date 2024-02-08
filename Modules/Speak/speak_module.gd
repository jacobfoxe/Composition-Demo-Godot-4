class_name SPEAK extends Node

@export_group("Nodes")
@export var individual : CharacterBody2D	# Parent node that does any movement. 

#/
## Determine if the character should speak. 
func handleSpeakInput(): 
	if Input.is_action_just_pressed("ui_speak"):
		print("My name is: " + individual.Name)
		
