extends ParallaxBackground


export(float) var scrolling_speed = 100.0

func _process(delta):
	scroll_offset.x -= scrolling_speed * delta
