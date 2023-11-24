extends CanvasLayer

func _ready():
    Global.time = 100

func _process(delta):
    var current_score_text = str(Global.score)
    if $HUDContainer/PontosContainer/PontosValor.text != current_score_text:
        $HUDContainer/PontosContainer/PontosValor.text = current_score_text
    
    var current_time_text = str(floor(Global.time))
    if $HUDContainer/TempoContainer/TempoValor.text != current_time_text:
        $HUDContainer/TempoContainer/TempoValor.text = current_time_text
