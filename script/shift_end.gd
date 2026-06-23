extends Control

var triggered = false
var is_dialogue_running = false
var is_waiting_rentry = false
@export var timer : Timer

func _ready() -> void:
	$AnimationPlayer.play("RESET")
	DialogueManager.got_dialogue.connect(_on_got_dialogue)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_got_dialogue(_line) -> void:
	is_dialogue_running = true

func _on_dialogue_ended(_resource) -> void:
	is_dialogue_running = false

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("appear")
	triggered = true

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("appear")

func trigger():
	if not is_dialogue_running and DayAndNightCycleManager.hour >= 17 and triggered == false and not is_waiting_rentry:
		is_waiting_rentry = true #block re entering 60 times a sec and finishes reading
#		timer.start() #timer of 1sec
#		await timer.timeout
		pause()

func _on_change_scene_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://scenes/home/home.tscn")
	
func _on_resume_pressed() -> void:
	resume()

func _process(_delta: float) -> void:
	trigger()
