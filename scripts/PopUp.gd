extends Control

var playButton

# Called when the node enters the scene tree for the first time.
func _ready():
	#Se conecta con la señal indicada
	Signals.connect("newpopup", resetGame)
	#Se obtiene el botón
	playButton = get_node('CenterContainer/Panel/VBoxContainer/Button')
	#Se conecta con la función correspondiente en caso de ser presionado
	playButton.connect("pressed", newGame)
	get_tree().set_pause(true)

func newGame():
	#Se inicia el juego desde cero
	get_tree().set_pause(false)
	self.queue_free()
	
func resetGame():
	#Se establece la interfaz del popUp
	$CenterContainer/Panel/VBoxContainer/TextureRect.set_texture(load("res://assets/ui/popup_complete.png"))
	$CenterContainer/Panel/VBoxContainer/Label.text = "Game Over! You got " + str(EndlessRunnerManager.score) + " coins!"
	#Se obtiene el botón
	playButton = get_node('CenterContainer/Panel/VBoxContainer/Button')
	#Se conecta con la función correspondiente en caso de ser presionado
	playButton.connect("pressed", startGame)

func startGame():
	#Se emite la señal correspondiente para que el juego se reinicie
	Signals.emit_signal("resetgame")
	#Se libera la partida terminada
	self.queue_free()
