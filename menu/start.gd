extends Button

func _on_pressed() -> void:
	var new_scene = load("res://main.tscn").instantiate()
	get_tree().root.add_child(new_scene)

	var current = get_tree().current_scene
	if current:
		current.queue_free()

	get_tree().current_scene = new_scene


func _on_out_pressed() -> void:
	get_tree().quit()
