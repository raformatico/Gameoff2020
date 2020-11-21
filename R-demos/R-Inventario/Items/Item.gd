class_name ItemResource
extends Resource

export var name: String
enum ItemType {QUEST, COLLECTION}
export (ItemType) var type
export var texture: Texture
