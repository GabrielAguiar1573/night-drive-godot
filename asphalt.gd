extends Node2D

@export var velocidade: float = 400.0
var larguraTile: float = 96.0
var metadeTile: float = 48.0

func _physics_process(delta: float) -> void:
	for tile in get_children():
		tile.position.x -= velocidade * delta

	for tile in get_children():
		if tile.position.x <= -metadeTile:
			var maiorXDaLinha = pegarMaiorXDaLinha(tile.position.y)
			tile.position.x = maiorXDaLinha + larguraTile

func pegarMaiorXDaLinha(posicaoY: float) -> float:
	var maiorX = -99999.0

	for tile in get_children():
		if is_equal_approx(tile.position.y, posicaoY):
			if tile.position.x > maiorX:
				maiorX = tile.position.x

	return maiorX
