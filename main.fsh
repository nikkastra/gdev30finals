#version 330

// UV-coordinate of the fragment (interpolated by the rasterization stage)
in vec2 outUV;

// Color of the fragment received from the vertex shader (interpolated by the rasterization stage)
in vec3 outColor;

in vec4 outNormal;

// Final color of the fragment that will be rendered on the screen
out vec4 fragColor;

in vec4 outPos;

// Texture unit of the texture
uniform sampler2D tex;

uniform vec4 light;
uniform vec3 lightColor;
uniform float ambient;
uniform int shiny;

float diffuse = max(dot(normalize(light - outPos), outNormal), 0);

vec4 reflected = reflect(normalize(light - outPos), outNormal);
float specular = pow(max(dot(reflected, outPos), 0), shiny);

vec4 phong = ((ambient + diffuse + specular) * vec4(lightColor, 0));

void main()
{
	// Get pixel color of the texture at the current UV coordinate
	// and output it as our final fragment color
	fragColor = texture(tex, outUV) * phong;
}
