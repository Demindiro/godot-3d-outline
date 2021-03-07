shader_type canvas_item;

uniform float size = 5.0;
uniform vec4 outline_color: hint_color = vec4(1.0, 0.0, 0.0, 1.0);

void fragment() {
	bool do_discard = true;
	vec4 c = texture(TEXTURE, UV);
	lowp float closest_distance = 9999999.0;
	for (lowp float x = -size; x <= size; x += 1.0) {
		for (lowp float y = -size; y <= size; y += 1.0) {
			lowp float len = length(vec2(x, y));
			if (len > size) {
				continue;
			}
			lowp vec4 p = texture(TEXTURE, UV - SCREEN_PIXEL_SIZE.xy * vec2(x, y));
			if (c.r < p.r) {
				COLOR.rgb = outline_color.rgb;
				do_discard = false;
				closest_distance = min(closest_distance, len);
			}
		}
	}
	if (do_discard)
		discard;
	else
		COLOR.a = (size - closest_distance) / size * outline_color.a;
}