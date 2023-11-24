extends Node2D

onready var player = $Player

func _ready():
    for enemy in get_tree().get_nodes_in_group("enemy"):
        print(enemy)
        enemy.connect("playerHit", Global, "_on_player_hit")
        
    player.connect("playerDied", Global, "_on_player_died")
