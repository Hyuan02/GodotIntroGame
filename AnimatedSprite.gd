extends AnimatedSprite

const GRAVITY = 6.0;
const velocityX = 400;
const velocityY = -700;
var bodyNode
var timerNode
var motion = Vector2(0,0);
var direction = Vector2(1,0);
const NORMAL =  Vector2(0,-1)
var shooting = true;

const bulletScene = preload("res://Projectile.tscn");

func _ready():
	bodyNode = get_node("../")
	timerNode = get_node("../ShootTimer")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	checkAnimation()
	checkTimer()
	pass
	
# warning-ignore:unused_argument
func _physics_process(delta):
	checkControls()
	motion.y +=20
	motion = bodyNode.move_and_slide(motion, NORMAL)
	pass



func checkControls():
		if(Input.is_key_pressed(KEY_RIGHT)):
			motion.x = velocityX
			direction = direction.abs()
		elif(Input.is_key_pressed(KEY_LEFT)):
			motion.x = -velocityX
			direction = -direction.abs()
		elif(Input.is_key_pressed(KEY_SPACE)):
			if(bodyNode.is_on_floor()):
				motion.y = velocityY
		elif(Input.is_key_pressed(KEY_Z)):
			if(!shooting):
				shooting = true
				shootBullet()
		else:
			motion.x = 0
		pass
		
func checkAnimation():
	if(motion.y != 0):
		self.animation = "Jump"
	else:
		if(motion.x>0):
			if(shooting):
				self.animation = "Run_Shoot"
			else:
				self.animation = "Run"
			self.set_flip_h(false);
		elif(motion.x<0):
			if(shooting):
				self.animation = "Run_Shoot"
			else:
				self.animation = "Run"
			self.set_flip_h(true)
		else:
			if(shooting):
				self.animation = "Shoot"
			else:
				self.animation = "Idle"

func shootBullet():
	var bullet = bulletScene.instance();
	self.add_child(bullet);
	bullet.launch(direction, global_position + (Vector2(200,100) * Vector2(direction.x, 1)));
	timerNode.start();
	pass
	
func checkTimer():
	if(shooting):
		if(timerNode.is_stopped()):
			shooting = false
	pass