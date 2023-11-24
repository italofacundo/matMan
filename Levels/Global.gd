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

func _process(delta):
    time -= delta
    if time <= 0:
        time = 0
        emit_signal("timeEnded")
    if lives == 0:
        if checkHudUpdated(livesPath, lives):
            print("GAME OVER")
            get_tree().paused = true
    if score == neededScore:
        print("YOU WIN")
        get_tree().paused = true

func checkHudUpdated(hudPath, testVariable):
    return hudPath.text == str(testVariable)
