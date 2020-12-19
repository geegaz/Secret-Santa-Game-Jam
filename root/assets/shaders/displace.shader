shader_type canvas_item;
render_mode unshaded;

const float PI = 3.14159;
//uniform float stretch : hint_range(-10.0,10.0) = 0.0;
uniform vec2 displacement = vec2(0.0,0.0);

void vertex() {
	VERTEX += displacement;
}