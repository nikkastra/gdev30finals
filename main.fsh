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
uniform vec3 lightAmbient;
uniform vec3 lightDiffuse;
uniform vec3 lightSpecular;
uniform int shiny;

float diffusal = max(dot(normalize(light - outPos), outNormal), 0);

vec4 reflected = reflect(normalize(light - outPos), outNormal);
float speculars = pow(max(dot(reflected, outPos), 0), shiny);

vec3 ambient = lightAmbient;
vec3 diffuse = diffusal*lightDiffuse;
vec3 specular = speculars*lightSpecular;

vec4 phong = vec4((ambient + diffuse + specular), 0);

void main()
{
	// Get pixel color of the texture at the current UV coordinate
	// and output it as our final fragment color
	fragColor = texture(tex, outUV) * phong;
}
