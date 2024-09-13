extends Area3D

#signal area_entered(body)

func _ready():
	pass
	#connect("body_entered", self, "_on_body_entered")
	#connect("body_exited", self, "_on_body_exited")

func _on_body_entered(body):
	emit_signal("area_entered", body)
	print("Body entered: ", body.name)

func _on_body_exited(body):
	print("Body exited: ", body.name)
