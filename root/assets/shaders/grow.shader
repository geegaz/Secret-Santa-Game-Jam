shader_type canvas_item;

uniform vec2 amount = vec2(0.0);
const float PI = 3.14159;

void vertex() {
	VERTEX = VERTEX*(vec2(1.0)+amount);
}