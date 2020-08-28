extends InteractableItem

export var interaction_texture : Texture = preload("res://assets/MySprites/interaction/interactionhand.png")

export var remaining_uses := 3

func interaction_get_texture() -> Texture:
	return interaction_texture

func interaction_get_text() -> String:
	return "Drink Coffee"

func interaction_interact(interactionComponentParent : Node) -> void:
	print ("Drank coffee !!!")
	remaining_uses -= 1
	if (remaining_uses <= 0):
		queue_free()
