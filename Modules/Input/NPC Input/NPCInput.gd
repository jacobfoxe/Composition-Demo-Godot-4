## This node handles inputs for NPCs. In a real game, there will be a robust FSM here, generally. 
## Here, however, the inputs are controlled via a simple boolean to either stay stationary or
## move randomly. 
class_name NPC_INPUT extends INPUT

## Enumeration to handle the states of the movement FSM. 
enum MOVE_STATES {
	IDLE,	## No movement.
	WANDER	## Move randomly.
	}

@export var allowMovement : bool = false	## If TRUE, allow the NPC to switch to the WANDER state. 
@export var moveTimerElapse : float = 3.0 	## Set an elapse time for the move timer. Only matters if allowMovement is TRUE. 
@export var directionFrameThreshold : int = 200	## Number of frames before the NPC can change directions. 

@onready var moveTimer = $MoveTimer			## Timer node to handle FSM Transitions.  

var currentState : MOVE_STATES = MOVE_STATES.IDLE		## The current movement state of this NPC. 
var queueSwitch : bool									## TRUE if an FSM transition is queued. 
var dirCounter : int = 0								## Count the frames in one direction. 

func _ready():
	## If movement is allowed, set up the moveTimer ##
	if allowMovement:
		moveTimer.start(moveTimerElapse)
	
	currentState = MOVE_STATES.IDLE
	moveInput = 0
	jumpInput = false
		
#/
## Override the base INPUT function to contain a simple FSM. 
func handleMoveInputs(delta): 
	match(currentState):
		MOVE_STATES.IDLE:
			moveInput = 0
			jumpInput = false
			
			## If a state switch is queued, perform the switch ##
			if queueSwitch:
				## Pick a random direction ##
				moveInput = randf_range(-1.0, 1.0)
				currentState = MOVE_STATES.WANDER
				queueSwitch = false
				
		MOVE_STATES.WANDER:
			dirCounter += 1
			jumpInput = false
			
			## Check the direction counter to determine if the NPC should change direction ##
			if dirCounter >= directionFrameThreshold:
				moveInput = randf_range(-1.0, 1.0)
				dirCounter = 0
			
			## If a state switch is queued, perform the switch ##
			if queueSwitch:
				moveInput = 0
				jumpInput = false
				currentState = MOVE_STATES.IDLE
				queueSwitch = false
		_:
			## Default to IDLE ##
			currentState = MOVE_STATES.IDLE
			queueSwitch = false

#/
## Signal emitted from the moveTimer. 
func _on_moveTimer_Elapse():
	if randi() % 3:
		queueSwitch = true
