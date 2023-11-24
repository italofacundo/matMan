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
signal updateHud

func _ready():
    pass

func _process(delta):
    time -= delta
    if time <= 0:
        time = 0
        emit_signal("timeEnded")
    if lives == 0:
        emit_signal("updateHud")
        lives = 3
        print("GAME OVER!")
        get_tree().paused = true

    if score == neededScore:
        if check_hud_updated(scorePath, score):
            print("YOU WIN")
            get_tree().paused = true

func check_hud_updated(hudPath, testVariable):
    return hudPath.text == str(testVariable)
    
func reset_current_scene():
    print(lives)
    get_tree().reload_current_scene()

func _on_player_hit():
    lives -= 1
    print("Colisão inimigo-player. Vidas = " + str(lives))
    reset_current_scene()

func _on_player_died():
    print("GAME OVER")
    reset_current_scene()
