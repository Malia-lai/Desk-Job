extends Button


func _on_pressed() -> void:
	#tileset
	$Timer.start()
	await $Timer.timeout
	get_tree().change_scene_to_file("res://scenes/main menu/main_menu.tscn")
