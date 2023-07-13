extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	#Se conectan con la señales indicadas
	Signals.connect("updatescore", updateScore)
	Signals.connect("resetgame", resetGame)
	#Se establece el score
	self.text = str(EndlessRunnerManager.aux_score)

func updateScore():
	#Se actualiza el score
	self.text = str(EndlessRunnerManager.score)

func resetGame():
	#Se reinicia el score
	self.text = str(0)
