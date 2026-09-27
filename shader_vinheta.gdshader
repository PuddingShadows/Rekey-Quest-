shader_type canvas_item;


void fragment() {
	vec2 uv = UV * 2.0 - 1.0;
	float vignette = 1.0 - dot(uv, uv);
	vignette = clamp(vignette, 0.0, 1.0);
	COLOR = vec4(0.0, 0.0, 0.0, (1.0 - vignette) * 0.1);
}