shader_type canvas_item;
render_mode unshaded;

const float PI = 3.14159;

uniform float stripe_size: hint_range(0.0, 1.0) = 0.01;
uniform int stripe_number: hint_range(1, 100) = 20;
uniform float stripe_width: hint_range(0.0, 0.5) = 0.02;

uniform vec4 stripe_color: hint_color = vec4(1.0);

uniform vec2 grow = vec2(0.0);
uniform float rotate : hint_range(0.0, 3.14159) = 0.0;

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
	float rot = rotate + PI/2.0;
	vertex = rotateUVmatrix(vertex, 0.5/TEXTURE_PIXEL_SIZE, rot);
	vertex = vertex*(vec2(1.0)+grow);
	VERTEX = vertex;
}

void fragment() {
	vec4 color = vec4(0.0);
	
	vec2 vector = UV-vec2(0.5);
	float dist = length(vector);
	float angle = 2.0*PI/float(stripe_number);
	float current_angle = atan(vector.x,vector.y);
	
	if(dist < 0.5 && dist > 0.5-stripe_width) {
		if(mod(current_angle,angle) < stripe_size) {
			color = stripe_color;
		}
	}
	
	COLOR = color;
}