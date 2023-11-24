extends Control


func _ready():
    $controles/iniciarBTN.grab_focus()

func _on_iniciarBTN_pressed():
    get_tree().change_scene("res://Tela Inicial/TelaHistória.tscn")

func _on_ControlesBTN_pressed():
    get_tree().change_scene("res://Tela Inicial/TelaDeControles.tscn")

func _on_QuitBtn_pressed():
    get_tree().quit()
