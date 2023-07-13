extends Node2D

var Coin = preload("res://scenes/Coin.tscn")

func _ready():
	#Se conecta con la señal indicada
	Signals.connect("killplayer", gameover)

func _on_timer_timeout():
	#Se crea y se añade una nueva moneda a la escena
	var c = Coin.instantiate()
	add_child(c) 

func gameover():
	#Se eliminan los recursos del spawner
	queue_free()
