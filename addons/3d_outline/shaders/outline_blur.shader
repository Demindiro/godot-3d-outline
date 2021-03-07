shader_type canvas_item;

uniform float size = 10.0;
uniform vec4 outline_color: hint_color = vec4(1.0, 0.0, 0.0, 1.0);


vec4 custom_lod(sampler2D tex, vec2 pixel_size, vec2 uv) {
	vec4 c = texture(tex, uv);
	float s = 0.0;
	for (float x = -size; x <= size; x += 1.0) {
		for (float y = -size; y <= size; y += 1.0) {
			if (length(vec2(x, y)) > size)
				continue;
			c += texture(tex, uv + pixel_size.xy * vec2(x, y));
			s += 1.0;
		}
	}
	return c / s;
}


void fragment() {
	bool do_discard = true;
	vec4 c = texture(TEXTURE, UV);
	
	if (c.g >= 0.99)
		discard;
	
	vec4 l = custom_lod(TEXTURE, SCREEN_PIXEL_SIZE, UV);
	
	COLOR.rgb = outline_color.rgb;
	// TODO this causes the outline to be slightly detached from the main mesh
	//COLOR.a = l.r * outline_color.a * (1.0 - c.g);
	COLOR.a = l.r * outline_color.a;
}