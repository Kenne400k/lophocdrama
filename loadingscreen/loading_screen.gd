extends CanvasLayer

signal loading_screen_done

@onready var bar = $ProgressBar
@onready var anim = $AnimationPlayer

func _ready():
	anim.play("in")
	Loader.load_scene_async("res://gme.tscn")
	Loader.progress_changed.connect(_on_progress)
	Loader.done_loading.connect(_on_done)

func _on_progress(p):
	bar.value = p * 100

func _on_done(scene):
	anim.play("out")
	await anim.animation_finished
	emit_signal("loading_screen_done", scene)
