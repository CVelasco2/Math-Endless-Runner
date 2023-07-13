extends CharacterBody2D

@onready var animation = $AnimatedSprite
const SPEED = 300.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var b

#Se enumeran los estados del jugador
enum {
	JUMP,
	RUN,
	IDLE
}

var state = RUN

func _ready():
	#Se conecta con la señal indicada
	Signals.connect("killplayer", killplayer)

#Se establece el comportamiento del jugador
func _physics_process(delta):
	match state:
		#El jugador está corriendo/andando
		RUN:
			animation.play("Walk")
		#El  jugador salta
		JUMP:
			velocity.y = JUMP_VELOCITY
			animation.play("Jump")
			state = IDLE
		IDLE:
			pass
			
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
	
	#Si está en el suelo, se establece el estado RUN
	if is_on_floor():
		state = RUN

#Se establece el comportamiento si se presiona un botón
func _input(event):
	#Si se presiona el espacio y el jugador no está ya saltando
	if event.is_action_pressed("ui_accept") and is_on_floor():
		#Se emite la señal correspondiente para que el jugador salte
		Signals.emit_signal("playerjump")
		#Se establece el estado JUMP
		state = JUMP

#Si el jugador muere, se liberan los recursos
func killplayer():
	queue_free()
