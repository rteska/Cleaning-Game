extends Resource

class_name InvItem

@export var name: String = ""
@export var texture: Texture2D
@export var cleans: String = ""
@export var combines_with: String = ""
@export var cursor_texture: Texture2D
@export var base_texture: Texture2D
@export var alt_item_image: Texture2D
@export var alt_cursor_image: Texture2D

#Gets the texture of the inventory item
func get_texture():
	return texture

#Gets cleaning key of the inventory item
func get_what_it_cleans():
	return cleans

func get_cursor_texture():
	return cursor_texture
