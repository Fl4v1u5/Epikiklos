extends Node
#This file resets all variables to the default values when the user presses "Return" button

func _on_Return_pressed():
	
	global.NbOfEpcs = 0.0; 
	global.NbOfSgmnts = 0; 
	global.RadiusC = 0; 
	global.thicc = 0; 
	global.ColorC = Color(1.0, 0.0, 1.0); 
	global.ColorL = Color(0.0, 1.0, 1.0);
	
	get_tree().change_scene("res://Content/Scenes/Menu/Menu.tscn");


func _on_Grow_pressed():
	$circledrawer.progress = 0
