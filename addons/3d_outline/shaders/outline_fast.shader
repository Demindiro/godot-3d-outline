shader_type canvas_item;

uniform float size = 10.0;
uniform vec4 outline_color: hint_color = vec4(1.0, 0.0, 0.0, 1.0);

void fragment() {
	bool do_discard = true;
	vec4 c = texture(TEXTURE, UV);
	
	if (c.g == 1.0)
		discard;
	
	// Faster but less accurate ( = looks worse)
	for (float i = 0.0; i <= size; i += 1.0) {
		vec4 l = texture(TEXTURE, UV - vec2(SCREEN_PIXEL_SIZE.x, 0.0) * i);
		vec4 r = texture(TEXTURE, UV + vec2(SCREEN_PIXEL_SIZE.x, 0.0) * i);
		vec4 u = texture(TEXTURE, UV - vec2(0.0, SCREEN_PIXEL_SIZE.y) * i);
		vec4 d = texture(TEXTURE, UV + vec2(0.0, SCREEN_PIXEL_SIZE.y) * i);
		const float SQRT_2 = sqrt(2.0) / 2.0;
		vec4 rd = texture(TEXTURE, UV + SCREEN_PIXEL_SIZE.xy * vec2(1.0, 1.0) * i * SQRT_2);
		vec4 ld = texture(TEXTURE, UV + SCREEN_PIXEL_SIZE.xy * vec2(-1.0, 1.0) * i * SQRT_2);
		vec4 ru = texture(TEXTURE, UV + SCREEN_PIXEL_SIZE.xy * vec2(1.0, -1.0) * i * SQRT_2);
		vec4 lu = texture(TEXTURE, UV + SCREEN_PIXEL_SIZE.xy * vec2(-1.0, -1.0) * i * SQRT_2);
		float a = max(max(max(d.r, u.r), max(l.r, r.r)), max(max(rd.r, ld.r), max(ru.r, lu.r)));
		if (c.r < a) {
			COLOR.rgb = outline_color.rgb;
			do_discard = false;
			COLOR.a = (size - i) / size * outline_color.a;
			break;
		}
	}
	if (do_discard)
		discard;
}