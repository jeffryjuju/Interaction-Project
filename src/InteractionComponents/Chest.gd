extends StaticBody2D

var is_open := false

func _ready():
	$AnimationPlayer.stop()
	$AnimatedSprite.frame = 0

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Player

func interaction_get_text() -> String:
	return "Open"

func interaction_interact(interactionComponentParent : Node) -> void:
	if is_open:
		return
	
	$AnimationPlayer.play("Open")
	is_open = true
	
	collision_layer = collision_layer ^ 8
