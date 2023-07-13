extends Node2D

var Enemy1 = preload("res://scenes/Enemy1.tscn")

func _ready():
	#Se conecta con la señal indicada
	Signals.connect("killplayer", gameover)

func _on_timer_timeout():
	#Se crea y se añade un nuevo enemigo a la escena
	var e = Enemy1.instantiate()
	add_child(e) 

func gameover():
	#Se eliminan los recursos del spawner
	queue_free()
