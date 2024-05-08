extends Node2D

var speed = 100
var direction = 1

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animation_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
	elif ray_cast_left.is_colliding():
		direction = 1
		
	position.x += speed * delta * direction
	animation_sprite.flip_h = direction > 0


func _on_area_2d_body_entered(body):
	print("Damage made by this enemy!!")
	
	# Gets the player collition node and removes it, falling into ground.
	body.get_node("PlayerCollitionShape2D").queue_free()
	# Reset scene
	get_tree().reload_current_scene()
