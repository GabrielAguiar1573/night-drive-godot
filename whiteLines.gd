extends Node2D

@export var velocidade: float = 400.0
var larguraSegmento: float = 96.0
var metadeSegmento: float = 48.0

func _physics_process(delta: float) -> void:
	for linha in get_children():
		linha.position.x -= velocidade * delta

	for linha in get_children():
		if linha.position.x <= -metadeSegmento:
			var maiorXDaLinha = pegarMaiorXDaLinha(linha.position.y)
			linha.position.x = maiorXDaLinha + larguraSegmento

func pegarMaiorXDaLinha(posicaoY: float) -> float:
	var maiorX = -99999.0

	for linha in get_children():
		if is_equal_approx(linha.position.y, posicaoY):
			if linha.position.x > maiorX:
				maiorX = linha.position.x

	return maiorX
