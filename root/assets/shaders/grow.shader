shader_type canvas_item;

uniform float amount : hint_range(-100.0,100.0) = 0.0;
const float PI = 3.14159;

void vertex() {
	VERTEX = VERTEX*(1.0+amount);
}