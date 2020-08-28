extends Area2D

export var interaction_parent : NodePath

signal on_interactable_changed

var interaction_target : Node

func _process(delta):
	#buat input-an
	if (interaction_target != null and Input.is_action_just_pressed("interact")):
		#kondisi biar bisa interaksi, klo ga ada ya ga bisa
		if(interaction_target.has_method("interaction_interact")):
			interaction_target.interaction_interact(self)

func _on_InteractionComponent_body_shape_entered(body_id, body, body_shape, area_shape):
	var canInteract := false
	
	#buat cek kondisi apakah objek bisa untuk interaksi/engga
	if (body.has_method("interaction_can_interact")):
		canInteract = body.interaction_can_interact(get_node(interaction_parent))
	
	#klo ga bisa, return
	if not canInteract: 
		return
	
	#emit signal dan value dari body yang di-detect
	interaction_target = body
	emit_signal("on_interactable_changed", interaction_target)

func _on_InteractionComponent_body_exited(body):
	#buat null-in interaksi klo body-nya udah out of range
	if (body == interaction_target):
		interaction_target = null
		emit_signal("on_interactable_changed", null)
