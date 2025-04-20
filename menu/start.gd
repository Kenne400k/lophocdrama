extends Button

func _on_pressed() -> void:
	var load_scene = load("res://loadingscreen/LoadingScreen.tscn") # Đổi path nếu khác
	var load_instance = load_scene.instantiate()
	get_tree().get_root().add_child(load_instance)
	
	# Xoá scene hiện tại nếu muốn
	get_tree().current_scene.queue_free()


func _on_out_pressed() -> void:
	get_tree().quit()
