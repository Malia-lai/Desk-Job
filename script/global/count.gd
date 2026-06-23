extends Node

@onready var transition = get_tree().get_first_node_in_group("transition")

var day : int = 1
var is_entered = false
