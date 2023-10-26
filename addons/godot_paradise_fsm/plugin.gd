@tool
extends EditorPlugin

const PLUGIN_PREFIX = "GodotParadise"


func _enter_tree():
	add_custom_type(_add_prefix("FiniteStateMachine"), "Node", preload("res://addons/godot_paradise_fsm/finite_state_machine.gd"), preload("res://addons/godot_paradise_fsm/icon.png"))


func _exit_tree():
	remove_custom_type(_add_prefix("FiniteStateMachine"))
	
	
func _add_prefix(text: String) -> String:
	return "{prefix}{text}".format({"prefix": PLUGIN_PREFIX, "text": text}).strip_edges()
