class_name INVENTORY extends Node

@export var item_capacity : int = 5		# Maximum amount of items the inventory can hold. 
@export var mail_capacity : int = 5		# Maximum pieces of mail the inventory can hold. 

@export_group("Nodes")
@export var individual : CharacterBody2D	# Parent node that does any movement. 

var items : Array[ITEM]
var mail : Array[MAIL]

func _ready():
	if item_capacity > 0:
		individual.add_to_group("item_receiver")
		
	if mail_capacity > 0:
		individual.add_to_group("mail_receiver")
		
#/
## Adds a new item to the inventory if space permits (and returns true). Returns false otherwise. 
func addItem(newItem : ITEM) -> bool:
	if items.size() < item_capacity:
		items.push_back(newItem)
		return true
	else:
		print("Inventory is full! ")
		return false

#/
## Adds a new piece of mail to the mailbag if space permits (and returns true). Returns false otherwise. 
func addMail(newMail : MAIL) -> bool:
	if mail.size() < mail_capacity:
		mail.push_back(newMail)
		return true
	else:
		print("Mailbag is full! ")
		return false
