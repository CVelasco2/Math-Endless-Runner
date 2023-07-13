extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	#Se conecta con las señales indicadas
	Signals.connect("playerhurt", playerHurt)
	Signals.connect("coingained", coinGained)
	Signals.connect("playerjump", playerJump)
	Signals.connect("questioncorrect", questionCorrect)

func playerHurt():
	#Se emite el sonido correspondiente
	$PlayerHurt.play()

func coinGained():
	#Se emite el sonido correspondiente
	$CoinGained.play()

func playerJump():
	#Se emite el sonido correspondiente
	$PlayerJump.play()

func questionCorrect():
	#Se emite el sonido correspondiente
	$QuestionCorrect.play()
