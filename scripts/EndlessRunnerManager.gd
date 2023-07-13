extends Node

@onready var Game = get_node('/root/Game/') 
@onready var popUp = preload("res://scenes/PopUp.tscn")
@onready var operation_popUp = preload("res://scenes/Operation.tscn")

var score = 0
var aux_score = 0

#Called when the node enters the scene tree for the first time.
func _ready():
	#Se conecta con las señales indicadas
	Signals.connect("reward", rewardPlayer)
	Signals.connect("killplayer", newOperation)
	
	#Se instancia el pop up inicial
	var splash1 = popUp.instantiate()
	Game.add_child(splash1)

#Se llama para crear una nueva operación
func newOperation():
	if Game == null:
		Game = get_node('/root/Game/') 
	
	#Se instancia el pop up con operaciones
	var splash2 = operation_popUp.instantiate()
	Game.add_child(splash2)

#Se llama para continuar el juego
func continueGame():
	#Se continua el juego desde donde se ha dejado
	get_tree().reload_current_scene()
	score = aux_score

#Se llama para resetear el juego
func resetGame():
	if Game == null:
		Game = get_node('/root/Game/') 
	
	#Se instancia el pop up inicial
	var splash1 = popUp.instantiate()
	Game.add_child(splash1)
	
	#Se emite la señal indicada
	Signals.emit_signal("newpopup")

#Se llama para actualizar la puntuacion 
func rewardPlayer():
	#Se actualiza el score del jugador 
	score += 1
	aux_score = score
	
	#Se emite la señal indicada
	Signals.emit_signal("updatescore")
