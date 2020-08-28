extends Node

class_name DialoguePlayer

signal start_conversation
signal end_conversation

var title: String = ""
var text: String = ""

var _conversation_lines: Array #isi total baris dalem conversation (data json)
var _current_index: int = 0 #checkpoint baris

func start(dialogue_dict):
	emit_signal("start_conversation")
	_conversation_lines = dialogue_dict.values() #ambil data dari load_dialogue dari class DialogueBox
	_current_index = 0 #set checkpoint di 0
	_update()

func next():
	_current_index += 1 #checkpoint pindah ke baris selanjutnya
	assert(_current_index <= _conversation_lines.size())
	_update()

func _update():
	text = _conversation_lines[_current_index].text
	title = _conversation_lines[_current_index].name
	#klo conversation udah abis
	if(_current_index == _conversation_lines.size() - 1):
		emit_signal("end_conversation") #emit signal ke DialogueBox
