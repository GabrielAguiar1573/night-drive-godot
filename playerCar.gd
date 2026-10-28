extends CharacterBody2D

var faixaAtual: int = 1
var posicoesFaixa = [224.0, 324.0, 424.0]
@export var velocidadeTrocaFaixa: float = 400.0

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("faixaCima"):
		faixaAtual -= 1
		
	if Input.is_action_just_pressed("faixaBaixo"):
		faixaAtual += 1
		
	faixaAtual = clamp(faixaAtual, 0, 2)
	
	position.y = move_toward(
		position.y,
		posicoesFaixa[faixaAtual],
		velocidadeTrocaFaixa * delta
	)

func receberDanoVisual() -> void:
	$Sprite2D.modulate.a = 0.4
	await get_tree().create_timer(0.3).timeout
	$Sprite2D.modulate.a = 1.0
