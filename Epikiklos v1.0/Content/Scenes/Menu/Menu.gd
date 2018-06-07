extends Node

func _on_Global_pressed():
	get_tree().change_scene("res://Content/Scenes/Level/Main.tscn")

func _on_LineNbOfEpicicles_text_changed(new_text):
	global.NbOfEpcs = float(new_text)

func _on_LineNbOfSegments_text_changed(new_text):
	global.NbOfSgmnts = int(new_text)

func _on_LineRadiusOfCircumference_text_changed(new_text):
	global.RadiusC = int(new_text)

func _on_LineThiccness_text_changed(new_text):
	global.thicc = float(new_text)

func _on_LineNbOfEpicicles_text_entered(new_text):
	global.NbOfEpcs = float(new_text)

func _on_ColorPickerButtonCirc_color_changed(color):
	global.ColorC = color

func _on_ColorPickerButtonLine_color_changed(color):
	global.ColorL = color
