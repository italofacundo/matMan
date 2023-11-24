extends Control

func _on_Button_pressed():
	get_tree().change_scene("res://Tela Inicial/TelaSelecionarFases.tscn")
	Global.lives = 3
	Global.score = 0
