extends Area2D

class_name MAIL_MODULE

@export var mailbag : Array[MAIL]	## Array of pieces of mail to be delivered. 

#/
## Checks for the mail button input and then looks for any receivers. 
func checkMailInput():
	if mailbag.size() <= 0:
		return
	
	## Check for mail input. ##
	if Input.is_action_just_pressed("ui_mail"):
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
	
	if bodies.size() == 1 and bodies[0].is_in_group("mail_receiver"):
		return bodies[0]
	
	return null
		
