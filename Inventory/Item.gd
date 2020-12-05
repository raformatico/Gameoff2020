class_name ItemResource
extends Resource

export var name: String
enum ItemType {REGULAR, STACKABLE}
export (ItemType) var type
export var texture: Texture
export (Array, Resource) var texture_array
export var max_stack : int
export var quantity : int = 1
