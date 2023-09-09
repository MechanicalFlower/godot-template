shader_type canvas_item;

uniform float amount_x : hint_range(0, 128) = 8;
uniform float amount_y : hint_range(0, 128) = 8;

void fragment() {
  vec2 pos = UV;
  pos *= vec2(amount_x, amount_y);
  pos = ceil(pos);
  pos /= vec2(amount_x, amount_y);
  vec2 cellpos = pos - (0.5 / vec2(amount_x, amount_y));

  pos -= UV;
  pos *= vec2(amount_x, amount_y);
  pos = vec2(1.0) - pos;

  float dist = distance(pos, vec2(0.5));

  vec4 c = texture(TEXTURE, cellpos);
  COLOR = c * step(0.0, (0.5 * c.a) - dist);
}
