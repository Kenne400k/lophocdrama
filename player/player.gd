extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim = $container/AnimatedSprite2D
@onready var collision = $CollisionShape2D

func _ready():
	anim.play("idle")  # Mặc định khi game bắt đầu, nhân vật sẽ đứng yên

func _physics_process(delta: float) -> void:
	# Trọng lực
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta  # Áp dụng trọng lực khi không ở trên mặt đất
	else:
		# Khi đứng trên mặt đất, không cần trọng lực nữa (giữ velocity.y về 0 để không bị đẩy xuống)
		velocity.y = 0

	# Kiểm tra nhảy (Space)
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():  # Kiểm tra nếu phím Space được nhấn
		velocity.y = JUMP_VELOCITY  # Thiết lập vận tốc nhảy
		anim.play("jump")  # Chạy animation nhảy khi nhấn phím nhảy

	# Di chuyển trái/phải (A/D hoặc ← →)
	var move_left = Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT)
	var move_right = Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT)

	if move_left:
		velocity.x = -SPEED
		anim.flip_h = true  # Lật nhân vật khi di chuyển sang trái
		if is_on_floor():
			anim.play("run")  # Animation chạy khi đang di chuyển trên mặt đất
	elif move_right:
		velocity.x = SPEED
		anim.flip_h = false  # Đặt lại hình ảnh khi di chuyển sang phải
		if is_on_floor():
			anim.play("run")  # Animation chạy khi đang di chuyển trên mặt đất
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)  # Dừng lại khi không di chuyển
		if is_on_floor():
			anim.play("idle")  # Animation đứng yên khi không di chuyển

	# Kiểm tra khi đang nhảy (nếu nhân vật đang bay lên)
	if not is_on_floor() and velocity.y < 0:
		anim.play("jump")  # Chạy animation nhảy nếu không đứng trên mặt đất

	move_and_slide()  # Di chuyển nhân vật theo vận tốc đã tính toán
