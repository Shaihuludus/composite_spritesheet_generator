@tool
class_name CompositeSpriteDock extends Control

@onready var save_button: Button = $ScrollContainer/VBoxContainer/SaveButton
@onready var save_file_dialog: FileDialog = $SaveFileDialog
@onready var load_file_dialog: FileDialog = $LoadFileDialog
@onready var main_sprite: LineEdit = $ScrollContainer/VBoxContainer/HBoxContainer2/MainSprite
@onready var load_main_button: Button = $ScrollContainer/VBoxContainer/HBoxContainer2/LoadMainButton
@onready var add_child_sprite_button: Button = $ScrollContainer/VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/AddChildSpriteButton
@onready var child_sprite_list: ItemList = $ScrollContainer/VBoxContainer/VBoxContainer/HBoxContainer/ChildList
@onready var remove_child_sprite_button: Button = $ScrollContainer/VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/RemoveChildSpriteButton
@onready var sprite_child_list_2: VBoxContainer = $ScrollContainer/VBoxContainer/SpriteChildList2

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
	var chid_item: ChildSpriteRow = preload("res://addons/compositespritesheetgenerator/dock/child_sprite_row.tscn").instantiate()		
	sprite_child_list_2.add_child(chid_item)
	chid_item.child_file.text = file_name
		
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
	
