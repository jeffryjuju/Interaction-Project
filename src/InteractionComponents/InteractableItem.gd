extends Node
class_name InteractableItem

# By default interactable items are only available to the Player class
func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Player
