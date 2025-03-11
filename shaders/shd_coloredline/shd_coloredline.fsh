//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec4 color1;
uniform vec4 color2;
uniform vec2 alpha;

void main()
{
	vec4 texture = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 color = vec4(0, 0, 0, 0);
	vec4 darkest = color1;
	vec4 lightest = color2;
	darkest = darkest / vec4(255, 255, 255, 255);
	lightest = lightest / vec4(255, 255, 255, 255);
	
	darkest.a = texture.a;
	lightest.a = texture.a;
	
	if (distance(texture, vec4(0, 0, 0, alpha)) <= 0.1)
		color = darkest;
	else
		color = lightest;
	
	gl_FragColor.rgb = vec3(color.r, color.g, color.b);
	gl_FragColor.a = texture.a;
	
	if (distance(vec4(0, 0, 0, texture.a), vec4(0, 0, 0, 0)) <= 0.004)
		gl_FragColor = texture;
}
