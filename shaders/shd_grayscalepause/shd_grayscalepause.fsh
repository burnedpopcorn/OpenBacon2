//
// Grayscale shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord ); // get the textures color
	float average = (color.r + color.g + color.b) / 3.0;
	vec4 gray = vec4(average, average, average, color.a);
    gl_FragColor = gray;
}
