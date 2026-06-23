extends Control

@export var animation : AnimationPlayer

func _on_play_pressed() -> void:
	animation.play("play")
	await animation.animation_finished
	get_tree().change_scene_to_file("res://scenes/main menu/first_scene.tscn")




func _on_settings_pressed() -> void:
	animation.play("settings")
	await animation.animation_finished
	

func _on_about_pressed() -> void:
	animation.play("about")
	await animation.animation_finished


func _on_aboutexit_pressed() -> void:
	animation.play_backwards("about")
	
	
func _on_settingsexit_pressed() -> void:
	animation.play_backwards("settings")
