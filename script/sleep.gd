extends Control

@onready var interaction_area = get_tree().get_first_node_in_group("interactible")
@onready var interaction_area_novel = get_tree().get_first_node_in_group("novel")
@onready var interaction_area_clothes = get_tree().get_first_node_in_group("clothes")
@onready var interaction_area_certificate = get_tree().get_first_node_in_group("certificate")
@onready var interaction_area_coffee = get_tree().get_first_node_in_group("coffee")
@onready var interaction_area_tableau = get_tree().get_first_node_in_group("tableau")
@onready var interaction_area_canva = get_tree().get_first_node_in_group("canva")
@onready var interaction_area_palette = get_tree().get_first_node_in_group("palette")


#group to call interactionera

@onready var transition = get_tree().get_first_node_in_group("transition")
@onready var transit = transition.get_node("AnimationPlayer")
@onready var old_text = transition.get_node("Label")


var is_playing: bool = true

@export var timer : Timer


func _ready():
	$AnimationPlayer.play("RESET")
	interaction_area.interact = Callable(self, "trigger")
	interaction_area_novel.interact = Callable(self, "novel_read")
	interaction_area_clothes.interact = Callable(self, "clothes")
	interaction_area_certificate.interact = Callable(self, "certificate")
	interaction_area_coffee.interact = Callable(self, "coffee")
	interaction_area_canva.interact = Callable(self, "canva")
	interaction_area_tableau.interact = Callable(self, "tableau")
	interaction_area_palette.interact = Callable(self, "palette")
	
	
	
	
	#hey interaction era, when someone presses interact inside u call the trigger func


func trigger():
	if Input.is_action_pressed("interact") and is_playing:
		$AnimationPlayer.play("appear")
		is_playing = false
		
func novel_read():
	if Count.day == 1:
		if Input.is_action_pressed("interact"):
			DialogueManager.show_example_dialogue_balloon(load("res://dialog/story.dialogue"), "start")
	elif Count.day == 2:
		if Input.is_action_pressed("interact"):
			DialogueManager.show_example_dialogue_balloon(load("res://dialog/story2.dialogue"), "start")
	elif Count.day == 3:
		if Input.is_action_pressed("interact"):
			DialogueManager.show_example_dialogue_balloon(load("res://dialog/story3.dialogue"), "start")
		
func clothes():
	if Input.is_action_pressed("interact"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/clothes.dialogue"), "start")

func coffee():
	if Input.is_action_pressed("interact"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/coffee.dialogue"), "start")
	
func certificate():
	if Input.is_action_pressed("interact"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/certificate.dialogue"), "start")
		
func canva():
	if Input.is_action_pressed("interact"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/canva.dialogue"), "start")
	
func tableau():
	if Input.is_action_pressed("interact"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/tableauhome.dialogue"), "start")
		
func palette():
	if Input.is_action_pressed("interact"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/palette.dialogue"), "start")
		
		
func change_scene():
	print("sleep...")
	resume()
	
	
func resume():
	$AnimationPlayer.play_backwards("appear")
	is_playing = true
	

		
func _on_change_scene_pressed() -> void:
	Count.day += 1
	print("day: " + str(Count.day))

	if Count.day == 2 :
		change_scene()
		transit.play("transition")
		await transit.animation_finished
		print("animation done")
		get_tree().change_scene_to_file("res://scenes/office/mainscence.tscn")
		
	elif Count.day == 3:
		change_scene()
		old_text.text = "Is this how bordom feels like? There must be another way to live life I'm sure of it..."
		transit.play("transition")
		await transit.animation_finished
		get_tree().change_scene_to_file("res://scenes/office/mainscence.tscn")
		
	else:
		change_scene()
		old_text.text = "Getting fired isn't the scariest thing, feeling stuck in your life is."
		transit.play("transition")
		await transit.animation_finished
		print("animation done")
		get_tree().change_scene_to_file("res://scenes/main menu/end_scene.tscn")
		
	

func _on_resume_pressed() -> void:
	resume()
	print("not sleeping")
	
	
func _process(_delta: float) -> void:
	if  Count.is_entered and Count.day == 1:
		Count.is_entered = false
		timer.start()
		await timer.timeout
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/first_day_home.dialogue"), "start")
	if Count.is_entered and Count.day == 2:
		Count.is_entered = false
		timer.start()
		await timer.timeout
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/second_day_home.dialogue"), "start")
	if Count.is_entered and Count.day == 3:
		Count.is_entered = false
		timer.start()
		await timer.timeout
		DialogueManager.show_example_dialogue_balloon(load("res://dialog/third_day_home.dialogue"), "start")
