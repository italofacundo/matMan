extends CanvasLayer

func _ready():
    Global.time = 100
    Global.scorePath = $HUDContainer/PontosContainer/PontosValor
    Global.livesPath = $HUDContainer/VidasContainer/VidasValor
    Global.neededScorePath = $HUDContainer/PontosNecessariosContainer/PontosNecessariosValor/

func _process(delta):
    var current_score_text = str(Global.score)
    if $HUDContainer/PontosContainer/PontosValor.text != current_score_text:
        $HUDContainer/PontosContainer/PontosValor.text = current_score_text
    
    var current_time_text = str(floor(Global.time))
    if $HUDContainer/TempoContainer/TempoValor.text != current_time_text:
        $HUDContainer/TempoContainer/TempoValor.text = current_time_text
        
    var current_lives_text = str(Global.lives)
    if $HUDContainer/VidasContainer/VidasValor.text != current_lives_text:
        $HUDContainer/VidasContainer/VidasValor.text = current_lives_text
        
    var needed_points_text = str(Global.lives)
    if $HUDContainer/PontosNecessariosContainer/PontosNecessariosValor/.text != current_lives_text:
        $HUDContainer/PontosNecessariosContainer/PontosNecessariosValor/.text = current_lives_text
