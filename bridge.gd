extends Node2D

@export var velocidade: float = 400.0
var larguraSegmento: float = 48.0
var metadeSegmento: float = 24.0

func _physics_process(delta: float) -> void:
	for segmento in get_children():
		segmento.position.x -= velocidade * delta

	for segmento in get_children():
		if segmento.position.x <= -metadeSegmento:
			var maiorX = pegarMaiorX()
			segmento.position.x = maiorX + larguraSegmento

func pegarMaiorX() -> float:
	var maiorX = -99999.0

	for segmento in get_children():
		if segmento.position.x > maiorX:
			maiorX = segmento.position.x

	return maiorX
