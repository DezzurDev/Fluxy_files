#version 150

uniform vec4 ColorModulator = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec2 Size = vec2(1.0, 1.0);
uniform float Radius = 0.2;

in vec4 vertexColor;
in vec2 texCoord0;

out vec4 fragColor;

float roundedRectSDF(vec2 p, vec2 size, float radius) {
    vec2 d = abs(p) - size + radius;
    return min(max(d.x, d.y), 0.0) + length(max(d, 0.0)) - radius;
}

void main() {
    vec2 center = texCoord0 - 0.5;
    float sdf = roundedRectSDF(center, Size * 0.5, Radius);
    float alpha = clamp(0.5 - sdf, 0.0, 1.0);

    fragColor = vertexColor * ColorModulator;
    fragColor.a *= alpha;
}
