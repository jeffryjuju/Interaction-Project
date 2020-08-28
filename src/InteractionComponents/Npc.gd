extends InteractableItem
class_name npc

signal show_dialogue

func interaction_get_text() -> String:
	return "Talk"

func interaction_interact(interactionComponentParent : Node) -> void:
	print ("Talking to NPC !!!")
	emit_signal("show_dialogue")
