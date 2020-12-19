shader_type canvas_item;

const float PI = 3.14159;

uniform vec2 grow = vec2(0.0);
uniform float rotate : hint_range(0.0, 360.0) = 0.0;

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
	vec2 vertex = VERTEX;
	float rot = (rotate/360.0) * -2.0*PI + PI/2.0;
	vertex = rotateUVmatrix(vertex, 0.5/TEXTURE_PIXEL_SIZE, rot);
	vertex = vertex*(vec2(1.0)+grow);
	VERTEX = vertex;
}