extends Node2D


@onready var interaction_area_paint = get_tree().get_first_node_in_group("paint")


func _ready():
	interaction_area_paint.interact = Callable(self, "paint")
	
	
