extends Control

#Se cargan previamente las escenas necesarias
@onready var player_scene = preload("res://scenes/Player.tscn")
@onready var spawner_scene = preload("res://scenes/Spawner.tscn")
@onready var spawner_coins_scene = preload("res://scenes/SpawnerCoins.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#Se conecta con la señal indicada
	Signals.connect("resetgame", resetGame)

#Se llama para resetear el juego
func resetGame():
	#Se instancia el jugador
	var new_player = player_scene.instantiate()
	add_child(new_player)
	new_player.position.x = 186
	new_player.position.y = 463
	
	#Se instancia el spawner de monedas
	var new_spawner_coins = spawner_coins_scene.instantiate()
	add_child(new_spawner_coins)
	new_spawner_coins.position.x = 1243
	new_spawner_coins.position.y = 492
	
	#Se inicia el score a 0
	EndlessRunnerManager.score = 0
	
	#Se instancia el spawner de enemigos 
	var new_spawner = spawner_scene.instantiate()
	add_child(new_spawner)
	new_spawner.position.x = 1243
	new_spawner.position.y = 492
