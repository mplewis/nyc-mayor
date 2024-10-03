@tool
class_name Progress
extends Control

@export var progress: float = 0.8
@export var margin_left_px: int = 0
@export var margin_right_px: int = 0

@onready var outer: NinePatchRect = $Outer
@onready var inner: TextureRect = $Inner
@onready var pointer: TextureRect = $Pointer

var ok := false


func _ready():
	assert(outer, "Outer texture not found")
	assert(inner, "Inner texture not found")

	size = outer.size
	custom_minimum_size = outer.size

	ok = true


func _process(_delta):
	if not ok:
		return

	var p = clamp(progress, 0, 1)
	var total_width := outer.size.x
	p = _convert_scale(p, 0, 1, margin_left_px, total_width - margin_right_px) / total_width

	inner.texture.region.size.x = clamp(p * total_width, 0, total_width)
	inner.scale.x = p

	if pointer:
		pointer.position.x = inner.position.x + inner.texture.region.size.x - pointer.size.x / 2


func _convert_scale(
	val: float, old_from: float, old_to: float, new_from: float, new_to: float
) -> float:
	return new_from + (val - old_from) * (new_to - new_from) / (old_to - old_from)
