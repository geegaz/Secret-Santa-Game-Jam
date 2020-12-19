shader_type canvas_item;
render_mode unshaded;

uniform float blur_amount : hint_range(0.0, 5.0);
uniform vec4 panel_color : hint_color = vec4(1.0);
uniform float panel_participation : hint_range(0.0,1.0);

void fragment() {
	vec4 col = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur_amount);
	COLOR = mix(col, panel_color, panel_participation);
}