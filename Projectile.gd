extends KinematicBody2D

var velocity = Vector2.ZERO

const THROW_VELOCITY = Vector2(400,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if (collision != null):
		_on_impact(collision.normal)
		

func launch(direction, position):
	print("moving")
	print(get_tree())
	var scene = get_tree().current_scene
	get_parent().remove_child(self)
	scene.add_child(self)
	self.global_position = position
	velocity = THROW_VELOCITY * direction;

func _on_impact(normal: Vector2):
	self.remove_and_skip()
	pass