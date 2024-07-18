class_name Player
extends CharacterBody2D
@export var speed: float = 3
@export var sword_damage: int = 2

@export var health:int = 100
@export var max_health: int = 100
@export var death_prefab: PackedScene

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sword_area: Area2D = $SwordArea
@onready var hitbox_area: Area2D = $HitboxArea

var input_vector: Vector2 = Vector2(0,0)
var is_running: bool = false
var was_running: bool = false
var is_attacking: bool = false
var attack_coldown: float = 0.0
var hitbox_coldown: float = 0.0

func _process(delta: float) -> void:
	GameManeger.player_position = position
	
	read_input()
	update_attack_coldown(delta)

	if Input.is_action_just_pressed("attack"):
		attack()

	play_run_idle_animation()
	if not is_attacking:
		rotate_sprite()
		
	update_hitbox_detection(delta)	

func _physics_process(delta: float) -> void:

	var target_velocity = input_vector * speed * 100.00
	if is_attacking:
		target_velocity *= 0.25
	velocity = lerp(velocity, target_velocity, 0.05)
	move_and_slide()

func attack() -> void:
	if is_attacking:
		return
		
	animation_player.play("attack_side_1")
	attack_coldown = 0.6
	is_attacking = true

	
func read_input() -> void:
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var deadzone = 0.15
	if abs(input_vector.x) < 0.15:
		input_vector.x = 0.0
	if abs(input_vector.y) < 0.15:
		input_vector.y = 0.0
		
	var was_running = is_running
	is_running = not input_vector.is_zero_approx()
	
func play_run_idle_animation() -> void:
	if not is_attacking:
		if was_running != is_running:
			if is_running:
				animation_player.play("run")
			else: 
				animation_player.play("idle")
				
func rotate_sprite() -> void:
	
	if input_vector.x > 0:
		sprite.flip_h = false

	elif input_vector.x < 0:
		sprite.flip_h = true
		
func update_attack_coldown(delta: float) -> void:
		if is_attacking: 
			attack_coldown -= delta
			if attack_coldown <= 0.0:
				is_attacking = false
				is_running = false
				animation_player.play("idle")

func deal_damage_to_enemies() -> void:
	var bodies = sword_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy: Enemy = body
			var direction_to_enemy = (enemy.position - position).normalized()
			var attack_direction: Vector2
			if sprite.flip_h:
				attack_direction = Vector2.LEFT
			else:
				attack_direction = Vector2.RIGHT
			var dot_product = direction_to_enemy.dot(attack_direction)
			if dot_product >= 0.6:
				enemy.damage(sword_damage)
	
func damage(amount: int) -> void:
	if health <= 0: return
	health -= amount
	print("Player recebeu dano de: ", amount, "A vida total é de:",health )
	modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	if health <= 0:
		die()

func die() -> void:
	if death_prefab:
		var death_object = death_prefab.instantiate()
		death_object.position = position
		get_parent().add_child(death_object)
		
	queue_free()
		

func update_hitbox_detection(delta: float) -> void:
	hitbox_coldown -= delta
	if hitbox_coldown > 0: return
	
	hitbox_coldown = 0.5
	var bodies = hitbox_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy: Enemy = body
			var damage_amount = 1
			damage(damage_amount) 

func heal(amount: int) -> int:
	health += amount
	if health > max_health:
		health = max_health
	print("cura:", amount, " vida:", health)
	return health
			
		
