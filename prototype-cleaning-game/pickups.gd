extends Area2D

@export var item: InvItem
@export var item_texture: Texture2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#$Sprite2D.scale = $CollisionShape2D.scale * 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	item_texture = item.texture
	$Sprite2D.texture = item.texture

#func collect(inventory: Inventory):
	#inventory.insert(item)
	

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("interact"):
		queue_free()
	
