extends Node2D

var coneScene = preload("res://cone.tscn")
var potholeScene = preload("res://pothole.tscn")
var posicoesFaixa: Array[float] = [224.0, 324.0, 424.0]
var distancia: float = 0.0
var vidasAtuais: int = 3
var velocidadeObstaculos: float = 400.0
var gameOver: bool = false
var velocidadeNormalObstaculos: float = 400.0

@onready var distanciaLabel: Label = $CanvasLayer/DistanceLabel
@onready var vidasAtuaisLabel: Label = $CanvasLayer/LivesLabel
@onready var gameOverBox: CenterContainer = $CanvasLayer/CenterContainer

func _ready() -> void:
	criarObstaculo()
	vidasAtuaisLabel.text = str(vidasAtuais) + " Vidas"

func _process(delta: float) -> void:
	
	var fatorVelocidade = velocidadeObstaculos / velocidadeNormalObstaculos
	
	if not gameOver and Input.is_action_just_pressed("pausar"):
		get_tree().paused = not get_tree().paused
	
	if not get_tree().paused:
		distancia += 0.4 * fatorVelocidade * delta
		distanciaLabel.text = "%.1f km" % distancia
	
	if gameOver and Input.is_action_just_pressed("reiniciar"):
		get_tree().paused = false
		get_tree().reload_current_scene()

func criarObstaculo() -> void:
	var tipoObstaculo = randi_range(0, 1)
	var obstaculo
	
	if tipoObstaculo == 0:
		obstaculo = coneScene.instantiate()
		
	else:
		obstaculo = potholeScene.instantiate()
	
	obstaculo.atingiu_player.connect(_on_obstaculo_atingiu_player)
	obstaculo.velocidade = velocidadeObstaculos
	var faixaAleatoria = randi_range(0, 2)
	var larguraTela = get_viewport_rect().size.x
	
	obstaculo.position = Vector2(
		larguraTela + 100,
		posicoesFaixa[faixaAleatoria]
	)
	
	obstaculo.add_to_group("obstaculos")
	add_child(obstaculo)

func _on_spawn_timer_timeout() -> void:
	var obstaculosAtivos = get_tree().get_nodes_in_group("obstaculos").size()
	
	if obstaculosAtivos < 10:
		criarObstaculo()
		
	$SpawnTimer.wait_time = randf_range(0.4, 0.7)

func _on_obstaculo_atingiu_player() -> void:
	vidasAtuais -= 1
	vidasAtuais = max(vidasAtuais, 0)
	vidasAtuaisLabel.text = str(vidasAtuais) + " Vidas"
	$PlayerCar.receberDanoVisual()
	velocidadeObstaculos = 300
	$Bridge.velocidade = velocidadeObstaculos
	$Bridge2.velocidade = velocidadeObstaculos
	$BridgeStructure.velocidade = velocidadeObstaculos
	$Asphalt.velocidade = velocidadeObstaculos
	#$WhiteLines.velocidade = velocidadeObstaculos
	
	var obstaculosAtivos = get_tree().get_nodes_in_group("obstaculos")
	
	for obstaculo in obstaculosAtivos:
		obstaculo.velocidade = velocidadeObstaculos
		
	$SlowTimer.start()
	
	if vidasAtuais <= 0:
		gameOver = true
		get_tree().paused = true
		gameOverBox.visible = true

func _on_slow_timer_timeout() -> void:
	var obstaculosAtivos = get_tree().get_nodes_in_group("obstaculos")
	
	velocidadeObstaculos = velocidadeNormalObstaculos
	$Bridge.velocidade = velocidadeObstaculos
	$Bridge2.velocidade = velocidadeObstaculos
	$BridgeStructure.velocidade = velocidadeObstaculos
	$Asphalt.velocidade = velocidadeObstaculos
	#$WhiteLines.velocidade = velocidadeObstaculos
	
	for obstaculo in obstaculosAtivos:
		obstaculo.velocidade = velocidadeObstaculos
