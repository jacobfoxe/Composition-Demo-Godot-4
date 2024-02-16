## This node encompases all inventory functionality died to a generic individual. 
@tool
class_name INVENTORY extends Node

@export var item_capacity : int = 5		## Maximum amount of items the inventory can hold. 
@export var mail_capacity : int = 5		## Maximum pieces of mail the inventory can hold. 

@export_group("Nodes")
@export var individual : CharacterBody2D	## Parent node that does any movement. 

var items : Array[ITEM]		## Array of Items. 
var mail : Array[MAIL]		## Array of mail pieces. 

func _ready():
	if item_capacity > 0:
		individual.add_to_group("item_receiver")
		
	if mail_capacity > 0:
		individual.add_to_group("mail_receiver")
	
	updateNumLabels()

func _physics_process(delta):
	## This silences warning spam during construction ##
	if individual == null:
		return
		
	$VBoxContainer.position.x = individual.position.x - 60
	## NOTE: Ideally, the y would be linked to the sprite so that it was a fixed distance above the sprite itself. 
	$VBoxContainer.position.y = individual.position.y - (individual.position.y * .9)
	
#/
## Adds a new item to the inventory if space permits (and returns true). Returns false otherwise. 
func addItem(newItem : ITEM) -> bool:
	if items.size() < item_capacity:
		items.push_back(newItem)
		updateNumLabels()
		return true
	else:
		print("Inventory is full! ")
		return false

#/
## Adds a new piece of mail to the mailbag if space permits (and returns true). Returns false otherwise. 
func addMail(newMail : MAIL) -> bool:
	if mail.size() < mail_capacity:
		mail.push_back(newMail)
		print(individual.Name + " says thanks for the mail!")
		updateNumLabels()
		return true
	else:
		print("Mailbag is full! ")
		return false

#/
## Update the UI labels whenever an item/mail piece is added/removed. 
func updateNumLabels():
	%itemNum.text = str(items.size())
	%mailNum.text = str(mail.size())
