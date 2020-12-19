shader_type canvas_item;

uniform float degree = 0.05;
uniform float speed = 1.0;
uniform float offset = 0.0;
const float PI = 3.14159;

vec2 rotateUVmatrix(vec2 uv, vec2 pivot, float rotation)
{
	mat2 rotation_matrix = mat2(
		vec2(sin(rotation),-cos(rotation)),
		vec2(cos(rotation), sin(rotation))
	    );
	
	uv = uv*rotation_matrix;
	
	return uv;
}

void vertex() {
	float rot = (sin(TIME*speed + offset) * PI * degree) + PI/2.0;
	VERTEX = rotateUVmatrix(VERTEX, 0.5/TEXTURE_PIXEL_SIZE, rot);
}