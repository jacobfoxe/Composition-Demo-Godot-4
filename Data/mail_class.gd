extends Resource

class_name MAIL

@export var name : String
@export var sender : String
@export var receiver : String

@export_group("Mail Status")
@export var opened : bool = false

func open():
	opened = true
