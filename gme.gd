var loading = preload("res://LoadingScreen.tscn").instantiate()
add_child(loading)

loading.loading_screen_done.connect(func(scene):
	get_tree().change_scene_to_packed(scene)
)
