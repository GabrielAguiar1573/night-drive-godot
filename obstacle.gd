extends Area2D

signal atingiu_player
@export var velocidade: float = 400.0
@export var desaparecerAoColidir: bool = true

func _physics_process(delta: float) -> void:
	position.x -= velocidade * delta
	
	if position.x < -100:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "PlayerCar":
		atingiu_player.emit()
		
		if desaparecerAoColidir:
			queue_free()
