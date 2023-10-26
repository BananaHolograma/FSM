@tool
extends EditorPlugin

const PLUGIN_PREFIX = "GodotParadise"

func _enter_tree():


func _exit_tree():
	
	
func _add_prefix(text: String) -> String:
	return "{prefix}{text}".format({"prefix": PLUGIN_PREFIX, "text": text}).strip_edges()
