#version 330

// Vertex position
layout(location = 0) in vec3 vertexPosition;

// Vertex color
layout(location = 1) in vec3 vertexColor;

// Vertex UV coordinate
layout(location = 2) in vec2 vertexUV;

// Vertex UV coordinate
layout(location = 3) in vec3 vertexNormal;

// UV coordinate (will be passed to the fragment shader)
out vec2 outUV;

// Color (will be passed to the fragment shader)
out vec3 outColor;

out vec4 outNormal;

out vec4 outPos;

uniform mat4 mat;
uniform mat4 view;
uniform mat4 proj;
uniform mat4 normat;

void main()
{
	gl_Position = proj * view * mat * vec4(vertexPosition, 1.0);
	vec4 normals = normat * vec4(vertexNormal, 0.0);
	outNormal = normals;
	outUV = vertexUV;
	outColor = vertexColor;
	outPos = mat * vec4(vertexPosition, 1.0); //(vec4(0.5f, 0.0f, 1.25f, 1.0f)-gl_Position)/normalize(vec4(0.5f, 0.0f, 1.25f, 1.0f)-gl_Position);
}
