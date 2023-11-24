extends KinematicBody2D

var speed = 150
var anim_idle = "idle"
var anim_walk_horizontal_ED = "walkhorizontalED"
var anim_walk_horizontal_DE = "walkhorizontalDE"
var anim_walk_vertical_CB = "walkverticalCB"
var anim_walk_vertical_BC = "walkverticalBC"
var score = 0

signal playerDied

func _ready():
	Global.player = self
	WebSocket.connect("right", self, "_on_right")
	WebSocket.connect("left", self, "_on_left")
	WebSocket.connect("center", self, "_on_center")
	WebSocket.connect("up", self, "_on_up")
	WebSocket.connect("down", self, "_on_down")
	WebSocket.connect("confirm", self, "_on_confirm")
	
func _on_right():
	Input.action_release("ui_left")
	Input.action_press("ui_right")
	
func _on_left():
	Input.action_release("ui_right")
	Input.action_press("ui_left")

func _on_center():
	Input.action_release("ui_right")
	Input.action_release("ui_left")

func _on_up():
	Input.action_release("ui_down")
	Input.action_press("ui_up")
	
func _on_down():
	Input.action_release("ui_up")
	Input.action_press("ui_down")
	
func _on_confirm():
	Input.action_press("ui_accept")

func _process(delta):
	var input_direction = Vector2()

	if Input.is_action_pressed("ui_right"):
		input_direction.x = 1
	if Input.is_action_pressed("ui_left"):
		input_direction.x = -1
	if Input.is_action_pressed("ui_down"):
		input_direction.y = 1
	if Input.is_action_pressed("ui_up"):
		input_direction.y = -1

	input_direction = input_direction.normalized()

	$AnimatedSprite.play(get_animation_name(input_direction))

	var velocity = input_direction * speed
	move_and_slide(velocity)
	var lives = Global.lives

func get_animation_name(direction):
	if direction.x > 0:
		return anim_walk_horizontal_ED
	elif direction.x < 0:
		return anim_walk_horizontal_DE
	elif direction.y > 0:
		return anim_walk_vertical_CB
	elif direction.y < 0:
		return anim_walk_vertical_BC
	else:
		return anim_idle

func update_score(value):
	score += value
	Global.score = score
	print(Global.score)

func _on_Player_playerDied():
	emit_signal("playerDied")
	print("playerdied")
