extends Node


func _ready():
	for child in $"Do outline".get_children():
		$Outline.outline_node(child)
