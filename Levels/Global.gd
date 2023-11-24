extends Node

var score = 0
var time = 9999
var lives = 3
var neededScore = 5

var livesPath
var scorePath
var neededScorePath

var player

var navigation

signal timeEnded

func _ready():
    for enemy in get_tree().get_nodes_in_group("enemy"):
        enemy.connect("playerHit", self, "_on_player_hit")

func _process(delta):
    time -= delta
    if time <= 0:
        time = 0
        emit_signal("timeEnded")
    if lives == 0:
        print(livesPath)
        if check_hud_updated(livesPath, 0):
            print("GAME OVER")
            get_tree().paused = true
    if score == neededScore:
        if check_hud_updated(scorePath, score):
            print("YOU WIN")
            get_tree().paused = true

func check_hud_updated(hudPath, testVariable):
    return hudPath.text == str(testVariable)
    
func reset_current_scene():
    var current_scene = get_tree().get_current_scene()
    var current_scene_path = current_scene.filename  # Ensure your scenes are saved with a filepath
    get_tree().reload_current_scene()

func _on_player_hit():
    lives -= 1
    print("Colisão inimigo-player. Vidas = " + str(lives))
