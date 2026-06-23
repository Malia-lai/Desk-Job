extends Control

@onready var animation : AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	enter()

func enter():
		animation.play("open")
		print("first animation start")
		await animation.animation_finished
		print("first animation done")
		
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/cinematic/panel_1.dialogue"), "start")
		await DialogueManager.dialogue_ended
		animation.play("1-2")
		await animation.animation_finished
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/cinematic/panel_2.dialogue"), "start")
		await DialogueManager.dialogue_ended
		animation.play("2-3")
		await animation.animation_finished
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/cinematic/panel_3.dialogue"), "start")
		await DialogueManager.dialogue_ended
		animation.play("3-4")
		await animation.animation_finished
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/cinematic/panel_4.dialogue"), "start")
		await DialogueManager.dialogue_ended
		animation.play("close")
		await animation.animation_finished
		get_tree().change_scene_to_file("res://scenes/office/mainscence.tscn")
