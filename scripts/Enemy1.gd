extends "ScrollMovement.gd"

@onready var animation = $AnimatedSprite2D

#Se llama para establecer los movimientos y procesos fisicos del nodo
func _physics_process(delta):
	animation.play("Moving")
	move()

#Se llama para liberar el nodo cuando entra en contacto con otro cuerpo
func _on_damage_body_entered(body):
	#Si entra en contacto con el jugador
	if body.name == "Player":
		#Se emiten las señales correspondientes
		Signals.emit_signal("killplayer")
		Signals.emit_signal("playerhurt")
		queue_free()

#Se llama para liberar el nodo cuando sale de la pantalla
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
