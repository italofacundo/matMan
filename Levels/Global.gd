extends Node

var score = 0
var time = 9999

var player

var navigation

signal timeEnded

func _process(delta):
    time -= delta
    if time <= 0:
        time = 0
        emit_signal("timeEnded")
