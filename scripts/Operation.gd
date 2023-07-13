extends Control

#Enumeracion de los tipos de operaciones
enum Operators {
	ADD, 
	SUBTRACT, 
	MULTIPLY
}

#Se crean las variables necesarias
var operand1
var operand2
var operator
var correct
var answer
var random = RandomNumberGenerator.new()

#Se crean variables que almacenen los nodos de la escena
@onready var go = $CenterContainer/Panel/GoButton
@onready var exit = $CenterContainer/Panel/ExitButton
@onready var check = $CenterContainer/Panel/CheckButton

@onready var operand_one = $CenterContainer/Panel/Operand
@onready var operand_two = $CenterContainer/Panel/Operand2
@onready var label_operator = $CenterContainer/Panel/Operator
@onready var message = $CenterContainer/Panel/Message

@onready var answer_line = $CenterContainer/Panel/Answer

# Called when the node enters the scene tree for the first time.
func _ready():
	go.disabled = true
	go.visible = false
	#Se llama a la funcion que realiza la pregunta
	question()
	#Se obtiene la respuesta introducida
	answer_line.grab_focus()
	#Inicializamos el randomizador 
	random.randomize()

#Se establece el comportamiento si se presiona el boton Enter
func _physics_process(_delta):
	if Input.is_action_just_released("ui_accept"):
		if !check.disabled: 
			self._on_check_button_pressed()
			return
		if !go.disabled:
			self._on_go_button_pressed()
			return

#Se crea una nueva operacion
func question():
	operand1 = operand()
	operator = get_operator()
	match operator:
		#Suma de numeros enteros
		Operators.ADD:
			operator = "+"
			operand2 = operand()
			correct = operand1 + operand2
		#Resta de numeros enteros
		Operators.SUBTRACT:
			operator = "-"
			operand2 = operand()
			if operand1 < operand2:
				var aux = operand1
				operand1 = operand2
				operand2 = aux
			correct = operand1 - operand2
		#Multiplicación de numeros enteros
		Operators.MULTIPLY:
			operator = "x"
			operand2 = multiplicationOperand()
			correct = operand1 * operand2
	operand_one.text = str(operand1)
	operand_two.text = str(operand2)
	label_operator.text = operator
	answer_line.clear()

#Se genera un operando aleatorio
func operand():
	return random.randi_range(10,99)

#Se genera un operando aleatorio para multiplicacion
func multiplicationOperand():
	return random.randi_range(0,9)

#Se genera un operador
func get_operator():
	return random.randi_range(0,2)

#Se resetea el juego al pulsar el boton Exit
func _on_exit_button_pressed():
	EndlessRunnerManager.resetGame()
	queue_free()

#Se continua el juego si se pulsa sobre el boton Go
func _on_go_button_pressed():
	EndlessRunnerManager.continueGame()
	queue_free()

#Se comprueba la respuesta si se presiona sobre el boton Check
func _on_check_button_pressed():
	#Se obtiene la respuesta introducida
	answer = answer_line.text
	
	#Se comprueba que la respuesta no esta vacia
	if answer == "":
		return
	
	#Se comprueba que la respuesta es un numero
	for character in answer:
		if character in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]:
			pass
		else:
			message.text = "I'm sorry, the answer\nmust be a number"
			answer_line.clear()
			return
	
	#Se comprueba si la respuesta es incorrecta
	if answer != str(correct):
		message.text = "I'm sorry, the answer\nis"
		answer_line.text = str(correct)
		answer_line.editable = false
		check.disabled = true
		check.visible = false
		return
	
	#La respuesta es correcta
	message.text = "The answer is correct!"
	Signals.emit_signal("questioncorrect")
	answer_line.editable = false
	check.disabled = true
	check.visible = false
	go.disabled = false
	go.visible = true
