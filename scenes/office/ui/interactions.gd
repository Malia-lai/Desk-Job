extends Control

@onready var interaction_area_novel = get_tree().get_first_node_in_group("novel")
@onready var interaction_area_npc = get_tree().get_first_node_in_group("npc")
@onready var interaction_area_npc2 = get_tree().get_first_node_in_group("npc2")
@onready var interaction_area_sink = get_tree().get_first_node_in_group("sink")
@onready var interaction_area_paint = get_tree().get_first_node_in_group("paint")
@onready var interaction_area_computer = get_tree().get_first_node_in_group("computer")
@onready var interaction_area_printer = get_tree().get_first_node_in_group("printer")
@onready var interaction_area_reception = get_tree().get_first_node_in_group("reception")



@export var animation : AnimationPlayer
@export var new_set : TileMapLayer
@export var new_printer : TileMapLayer
@export var timer : Timer


func _ready():
	animation.play("open")
	interaction_area_novel.interact = Callable(self, "novel_read")
	interaction_area_npc.interact = Callable(self, "npc")
	interaction_area_npc2.interact = Callable(self, "npc")
	interaction_area_sink.interact = Callable(self, "sink")
	interaction_area_paint.interact = Callable(self, "paint")
	interaction_area_computer.interact = Callable(self, "computer")
	interaction_area_printer.interact = Callable(self, "printer")
	interaction_area_reception.interact = Callable(self, "reception")
	
	
func prank(name):
	if Input.is_action_pressed("interact"):
		DialogueManager.show_dialogue_balloon(load("res://dialog/" + name + ".dialogue"), "start")
		await DialogueManager.dialogue_ended
		get("interaction_area_" + name).get_node("CollisionShape2D").disabled = true	
		animation.play("transition_" + name)
		await animation.animation_finished
		DialogueManager.show_dialogue_balloon(load("res://dialog/" + name + "after.dialogue"), "start")
		

func novel_read():
	if Input.is_action_pressed("interact"):
		DialogueManager.show_dialogue_balloon(load("res://dialog/tableau.dialogue"), "start")

func npc():
	if Input.is_action_pressed("interact"):
			DialogueManager.show_example_dialogue_balloon(load("res://dialog/discuss.dialogue"), "start")

func sink():
	if Input.is_action_pressed("interact"):
			DialogueManager.show_example_dialogue_balloon(load("res://dialog/sink.dialogue"), "start")

func paint():
	prank("paint")
	
func printer():
	prank("printer")
	
func computer():
	prank("computer")

func reception():
	if Count.day == 1:
		if Input.is_action_pressed("interact"):
			DialogueManager.show_dialogue_balloon(load("res://dialog/reception_first.dialogue"), "start")
	if Count.day == 2:
		if Input.is_action_pressed("interact"):
			DialogueManager.show_dialogue_balloon(load("res://dialog/reception_second.dialogue"), "start")
	if Count.day == 3:
		if Input.is_action_pressed("interact"):
			DialogueManager.show_dialogue_balloon(load("res://dialog/reception_third.dialogue"), "start")
		

func _process(_delta: float) -> void:
	if not Count.is_entered and Count.day == 1:
		interaction_area_paint.get_node("CollisionShape2D").disabled = true
		interaction_area_computer.get_node("CollisionShape2D").disabled = true
		Count.is_entered = true
		timer.start()
		await timer.timeout
		DialogueManager.show_dialogue_balloon(load("res://dialog/first_day.dialogue"), "start")
		
		
	if not Count.is_entered and Count.day == 2 :
		Count.is_entered = true
		interaction_area_printer.get_node("CollisionShape2D").disabled = true
		interaction_area_computer.get_node("CollisionShape2D").disabled = true

		new_printer.visible = true
		new_printer.get_node("paper").visible = false
		timer.start()
		await timer.timeout
		DialogueManager.show_dialogue_balloon(load("res://dialog/second_day.dialogue"), "start")

	if not Count.is_entered and Count.day == 3 :

		interaction_area_paint.get_node("CollisionShape2D").disabled = true
		new_set.visible = true
		new_set.get_node("paint").visible = false
		new_printer.visible = true
		new_printer.get_node("paper").visible = false
		interaction_area_printer.get_node("CollisionShape2D").disabled = true
		Count.is_entered = true
		timer.start()
		await timer.timeout
		DialogueManager.show_dialogue_balloon(load("res://dialog/third_day.dialogue"), "start")
