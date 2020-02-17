extends AnimatedSprite

const GRAVITY = 6.0;

var speed = 5.0
var moving = Vector2(0,1)
const velocityX = 400;
const velocityY = -700;
var bodyNode;
var motion = Vector2(0,0);
const NORMAL =  Vector2(0,-1)

func _ready():
	bodyNode = get_node("../")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkAnimation()
	pass
	
func _physics_process(delta):
	checkControls()
	motion.y +=20
	motion = bodyNode.move_and_slide(motion, NORMAL)
	pass



func checkControls():
		if(Input.is_key_pressed(KEY_RIGHT)):
			motion.x = velocityX
		elif(Input.is_key_pressed(KEY_LEFT)):
			motion.x = -velocityX
		elif(Input.is_key_pressed(KEY_SPACE)):
			if(bodyNode.is_on_floor()):
				motion.y = velocityY
		else:
			motion.x = 0
		pass
		
func checkAnimation():
	if(motion.y != 0):
		self.animation = "Jump"
	else:
		if(motion.x>0):
			self.animation = "Run"
			self.set_flip_h(false);
		elif(motion.x<0):
			self.animation = "Run"
			self.set_flip_h(true)
		else:
			self.animation = "Idle"
	
	
