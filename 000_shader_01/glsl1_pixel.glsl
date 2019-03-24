
// Example Pixel Shader

uniform float uOffset;

out vec4 fragColor;
void main()
{
    vec4 color = vec4(0.5);

    vec4 color1 = texture(sTD2DInputs[0], vUV.st + vec2(uOffset, 0));
    vec4 color2 = texture(sTD2DInputs[1], vUV.st);

    color = color1 + color2;

    fragColor = TDOutputSwizzle(color);
}
