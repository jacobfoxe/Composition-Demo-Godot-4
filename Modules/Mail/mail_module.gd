## This node encompasses mail functionality for any individuals who can deliver mail. 
class_name MAIL_MODULE extends Area2D

@export var mailbag : Array[MAIL]	## Array of pieces of mail to be delivered. 

@export_group("Nodes")
@export var individual : CharacterBody2D	## Parent node that does any movement. 

#/
## Checks for the mail button input and then looks for any receivers. 
func checkMailInput():
	## Check for mail input. ##
	if Input.is_action_just_pressed("ui_mail"):
		## Check for empty mailbag ##
		if mailbag.size() <= 0:
			print("No mail left!")
			return
		
		var mailReceiver = checkTargetGroup()
		## Check if only one mail receiver is in the area. ##
		if mailReceiver != null:
			## Loop through mailbag. Could be set to an "active piece of mail".  ##
			for mail in mailbag:
				## Check if the individual is the receiver of this mail ##
				if mailReceiver.Name == mail.receiver:
					deliver_mail(mailReceiver, mail)
					return ## Only one piece of mail at a time ##

#/
## Call the target's mail reception function. 
func deliver_mail(mail_target : CharacterBody2D, mail : MAIL):
	if mail_target.receiveMail(mail):
		## Only erase if the mail is received properly ##
		mailbag.erase(mail)

#/
## This checks any targets within the area2D for the "mail_receiver" group. 
func checkTargetGroup() -> CharacterBody2D:
	var bodies = get_overlapping_bodies()
	
	## Check for the mail_receiver group. 
	## NOTE: This can be made cleaner by changing collision masks. 
	for body in bodies:
		if body.is_in_group("mail_receiver") and body is CharacterBody2D and body.Name != individual.Name:
			return body
	
	return null
		
