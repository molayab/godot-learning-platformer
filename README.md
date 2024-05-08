# Learning Godot Engine:

Godot is a open source game engine that simplifies the 2D and 3D game creation, it defines 
scenes that can interact between and run custom script to bring logic to the game.

This is a platformer-game that will introduce all the most basic knowledge about the game 
development. All the art is open-source and free to download to only focus on logic and 
code. 

### Character 

This is the main actor in our game, controller controls this entity and define the base 
physics logic. 

In Godot we should use a CharacterBody2D to get the engine already defined body control 
script. We can modify it as required to adquire custom physics. All charactes MUST define 
a collition shape to define the boundaries of the interaction. It means we have to define an
area that will execute the collition logic. 

It is important to note that Collitions are based on layers, it means we can react to 16 different 
collition layers, it is useful when only want to trigger signals (or events) on certan layer. Player
for examnple can be on the layer 16, and coins should only interact with layer 16 because only the 
player can take coins in this example. On the other hand, enemies can be assigned to layer 1 to only
calculate the basic collitions like ground or solid-block.

*Camera*
Using camera in Godot seems be easy, it is another node that we can assign to the scene. For 2D,
Camera2D object is used and Camera3D on the 3D world. Adding the camera inside of any scene, will 
cause that camera follow that scene if some movement is defined. Then, it is easy to follow player 
defining a camera inside it. Yo can also limit camera movement defining some boundaries in the properties.
Default properties also take care of smoothment movement of the camera.

*Animations*
For 2D world animations are easy, basically it is a list of diferent animation sets (idle, running, 
climbing, etc...) and a sprite is set for each frame of the animation. Then you can easily access to 
code and change animation as needed. 

```
if not is_on_floor():
		velocity.y += gravity * delta
		$AnimationSprite.animation = "falling"
	else: 
		if velocity.x == 0:
			$AnimationSprite.animation = "idle"
		else:
			$AnimationSprite.animation = "running"
		jumps = 0
```

### Collectables 
Collectables are not different than Character, it is self-encapsulated scene, for example, 
in this project coins are created to only interact with Player on collition layer 16, 
when the player walks inside the scene the logic for add coin is trigger and the sprite 
is removed from screen. Check `queue_free()` method that removes Node from scene.

### Enemies
Enemies are scenes that interacts with player, it defines a killzone area that will kill or 
decrease health of the player if entered. It also ray casts and check of is colliding to left or
right corner and inverts the movement to give a very basic enemy AI that keeps avoiding crash with 
walls.

#### RayCasting
Godot give a simple and intiutive way to use ray casts, it is defined on the built-in nodes in the 
engine, and the node provides a signal to check if cast is colling with something.
