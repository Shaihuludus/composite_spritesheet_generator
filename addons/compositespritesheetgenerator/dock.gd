@tool
class_name CompositeSpriteDock extends Control

@onready var save_button = $Button
@onready var save_file_dialog: FileDialog = $SaveFileDialog
@onready var load_file_dialog: FileDialog = $LoadFileDialog
@onready var main_sprite: LineEdit = $Panel/LineEdit
@onready var load_main_button: Button = $Panel/LoadMainButton
@onready var add_child_sprite_button: Button = $AddChildSprite
@onready var child_sprite_list: ItemList = $ItemList
@onready var remove_child_sprite_button: Button = $RemoveChildSprite

var display_sprites: DisplaySprites

func connect_ds(ds : DisplaySprites):	
	display_sprites = ds
		
	save_button.connect("pressed", self.pressed_save)
	save_file_dialog.connect("file_selected", self.save)	
	load_main_button.connect("pressed", self.load_main_sprite)	
	add_child_sprite_button.connect("pressed", self.load_child_sprite)
	remove_child_sprite_button.connect("pressed", self.remove_child_sprite)
	
func remove_child_sprite():
		if child_sprite_list.is_anything_selected():
			var child_to_remove: int = child_sprite_list.get_selected_items()[0]
			display_sprites.delete_child_sprite(child_sprite_list.get_selected_items()[0])
			child_sprite_list.remove_item(child_to_remove)
		pass
	
func load_child_sprite():
	load_file_dialog.popup_file_dialog()
	load_file_dialog.connect("file_selected", self.add_child_sprite)
	pass	
	
func add_child_sprite(file_name: String):
	display_sprites.add_child_sprite(file_name)
	child_sprite_list.add_item(file_name)
	load_file_dialog.disconnect("file_selected", self.add_child_sprite)
	pass
	
func load_main_sprite():
	load_file_dialog.popup_file_dialog()
	load_file_dialog.connect("file_selected", self.set_main_sprite)

func set_main_sprite(file_name: String):
	display_sprites.set_main_sprite(file_name)
	main_sprite.text = file_name
	load_file_dialog.disconnect("file_selected", self.set_main_sprite)
	pass

func pressed_save():
	save_file_dialog.popup_file_dialog()	

func save(file: String):	
	display_sprites.sub_viewport.snapshot(file)
	
