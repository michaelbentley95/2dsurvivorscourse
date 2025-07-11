extends CanvasLayer
class_name EndScreen

func _ready():
	get_tree().paused = true
	$%RestartButton.pressed.connect(on_restart_button_pressed)
	$%QuitButton.pressed.connect(on_quit_button_pressed)
	
func set_defeat():
	$%TitleLabel.text =  "Defeat"
	$%DescriptionLabel.text =  "You lost!"

func on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")

func on_quit_button_pressed():
	get_tree().quit()
