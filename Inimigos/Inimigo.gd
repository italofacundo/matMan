extends KinematicBody2D

export (NodePath) var path_to_player

var _velocity := Vector2.ZERO
var path := []

onready var _navigation: Navigation2D = get_parent()
onready var _agent: NavigationAgent2D = $NavigationAgent2D
onready var _player = get_node_or_null(path_to_player)
onready var _timer: Timer = $Timer
onready var _sprite: AnimatedSprite = $InimigoSprite

func _ready() -> void:
    _timer.wait_time = 0.5
    _timer.autostart = true
    _timer.one_shot = false
    _timer.start()
    _timer.connect("timeout", self, "_update_pathfinding")
    $InimigoArea2D.connect("area_entered", self, "_on_InimigoArea2D_area_entered")

func _physics_process(delta: float) -> void:
    if not _player or path.size() == 0:
        return

    var next_point = path[0]
    var direction = global_position.direction_to(next_point)
    var desired_velocity = direction.normalized() * 125.0
    _velocity = _velocity.linear_interpolate(desired_velocity, 0.1)
    move_and_slide(_velocity)
    if global_position.distance_to(next_point) < 10:
        path.remove(0)
    
    if _velocity.x > 0 and abs(_velocity.x) > abs(_velocity.y):
        _sprite.play("Right")
    elif _velocity.x < 0 and abs(_velocity.x) > abs(_velocity.y):
        _sprite.play("Left")
    elif _velocity.y < 0 and abs(_velocity.y) > abs(_velocity.x):
        _sprite.play("Up")
    elif _velocity.y > 0 and abs(_velocity.y) > abs(_velocity.x):
        _sprite.play("Down")
    else:
        _sprite.play("Idle")

func _update_pathfinding() -> void:
    if _player:
        path = _navigation.get_simple_path(global_position, _player.global_position, false)

func _on_InimigoArea2D_area_entered(area):
    if area.name == "InimigoArea2D":
        print("Colisão entre inimigos")
        queue_free()
    if area.name == "PlayerArea2D":
        Global.lives -= 1
        print("Colisão inimigo-player. Vidas = " + str(Global.lives))
