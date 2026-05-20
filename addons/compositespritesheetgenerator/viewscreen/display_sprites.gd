@tool
class_name DisplaySprites extends Node2D

@onready var sprite_sheet_main_view: Sprite2D = $SpriteSheetMainView
@onready var sub_viewport = $SubViewport

var child_sprites: Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
	reloadMainView()	
	
