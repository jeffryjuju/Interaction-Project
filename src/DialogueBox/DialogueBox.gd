extends Control

signal dialogue_ended

export var interaction_component_nodepath : NodePath
#json data buat dialog
export (String, FILE, "*.json") var dialogue_file_path: String

#ngambil node dialogue player
onready var dialogue_player: DialoguePlayer = get_node("DialoguePlayer")

onready var name_label:= get_node("Panel/Columns/Name") as Label
onready var text_label:= get_node("Panel/Columns/Text") as Label

onready var button_next:= get_node("Panel/Columns/ButtonNext") as Button
onready var button_finished:= get_node("Panel/Columns/ButtonFinished") as Button

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(interaction_component_nodepath).connect("show_dialogue", self, "initiate_dialogue")
	hide()

func initiate_dialogue() -> void:
	#ini buat manggil func load_dialogue
	var dialogue: Dictionary = load_dialogue(dialogue_file_path)
	
	button_finished.hide()
	button_next.show()
	button_next.grab_focus()
	dialogue_player.start(dialogue) #passing data ke DialoguePlayer
	update_content()
	show()

func update_content() -> void:
	#buat update isi di DialogueBox
	name_label.text = dialogue_player.title
	text_label.text = dialogue_player.text

func load_dialogue(file_path) -> Dictionary:
	#func buat load data dalem json-nya
	var file = File.new()
	assert(file.file_exists((file_path)))
	
	file.open(file_path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	assert(dialogue.size() > 0) #buat mastiin json ga kosong
	return dialogue

func _on_ButtonNext_pressed():
	dialogue_player.next()
	update_content()

#observer buat signal end_conversation dari DialoguePlayer
func _on_DialoguePlayer_end_conversation():
	button_next.hide()
	button_finished.show()
	button_finished.grab_focus()

func _on_ButtonFinished_pressed():
	emit_signal("dialogue_ended")
	hide()
