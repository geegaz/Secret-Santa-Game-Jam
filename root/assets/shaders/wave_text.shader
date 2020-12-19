shader_type canvas_item;

uniform float speed = 4.0;
uniform float range = 2.0;
uniform float scale = 20.0;

void vertex() {
	VERTEX.y = VERTEX.y+sin(TIME*speed+(VERTEX.x/scale))*range;
}