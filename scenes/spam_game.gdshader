shader_type canvas_item;

uniform vec4 bar_color : source_color = vec4(0.53, 0.81, 0.92, 1.0);

void fragment() {
	COLOR *= bar_color;
}