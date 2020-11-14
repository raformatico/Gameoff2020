class_name ItemResource
extends Resource

export var name: String
export var stackable: = false
export var max_stack_size: = 1

enum ItemType {QUEST, COLLECTION}
export (ItemType) var type
export var texture: Texture
