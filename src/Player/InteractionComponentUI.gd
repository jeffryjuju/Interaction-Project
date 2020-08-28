extends Control
class_name InteractionComponentUI

export var interaction_component_nodepath : NodePath

export var interaction_texture_nodepath : NodePath
export var interaction_text_nodepath : NodePath
export var interaction_default_texture : Texture
export var interaction_default_text : String

var fixed_position : Vector2

func _ready():
	get_node(interaction_component_nodepath).connect("on_interactable_changed", self, "interactable_target_changed")
	
	hide()

func _process(delta):
	set_global_position(fixed_position)
	
func interactable_target_changed(newInteractable : Node) -> void:
	#kalo ga ada apa", hide UI interaksi
	if (newInteractable == null):
		hide()
		return
	
	#set default texture n text
	var interaction_texture := interaction_default_texture
	var interaction_text := interaction_default_text
	
	#klo ada custom texture/text
	if (newInteractable.has_method("interaction_get_texture")):
		interaction_texture = newInteractable.interaction_get_texture()
	
	if (newInteractable.has_method("interaction_get_text")):
		interaction_text = newInteractable.interaction_get_text()
	
	get_node(interaction_texture_nodepath).texture = interaction_texture
	get_node(interaction_text_nodepath).text = interaction_text
	
	fixed_position = Vector2(newInteractable.get_global_position().x, newInteractable.get_global_position().y - 50)
	
	self.set_global_position(fixed_position)
	
	show()
