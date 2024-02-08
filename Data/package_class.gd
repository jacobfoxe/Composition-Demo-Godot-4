class_name PACKAGE extends MAIL

@export var contents : Array[ITEM]	# List of items

#/
## Removes an item from the package. 
func retrieveItem(item : ITEM):
	if opened and item in contents:
		contents.erase(item)

#/
## Shows all items inside the package. 
func getContents() -> Array[ITEM]:
	if opened:
		return contents
	else:
		return []
