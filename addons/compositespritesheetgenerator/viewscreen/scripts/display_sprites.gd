@tool
class_name DisplaySprites extends Node2D

@onready var sprite_sheet_main_view: Sprite2D = $SpriteSheetMainView
@onready var sub_viewport = $SubViewport

var child_sprites: Array[String] = []

func delete_child_sprite(sprite_index: int):
	child_sprites.remove_at(sprite_index)
	reloadMainView()
	
func add_child_sprite(file_name: String):	
	child_sprites.append(file_name)
	reloadMainView()

func reloadMainView():
	var children: Array[Node] = sprite_sheet_main_view.get_children()
	for child in children:
		sprite_sheet_main_view.remove_child(child)
		child.queue_free()		
	for file_name in child_sprites:	
		var childSprite: Sprite2D = Sprite2D.new() 
		childSprite.texture = load(file_name)	
		sprite_sheet_main_view.add_child(childSprite)		

func set_main_sprite(file_name: String):
	sprite_sheet_main_view.texture = load(file_name)
	sprite_sheet_main_view.position.x = sprite_sheet_main_view.texture.get_size().x / 2
	sprite_sheet_main_view.position.y = sprite_sheet_main_view.texture.get_size().y / 2
	reloadMainView()

func set_sprite_index(sprite_index: int, z_index: int):
	if sprite_sheet_main_view:
		sprite_sheet_main_view.get_child(sprite_index).z_index = z_index

func set_sprite_x_offset(sprite_index: int, offset: int):
	if sprite_sheet_main_view:
		sprite_sheet_main_view.get_child(sprite_index).position.x = offset	

func set_sprite_y_offset(sprite_index: int, offset: int):
	if sprite_sheet_main_view:
		sprite_sheet_main_view.get_child(sprite_index).position.y = offset				
	
