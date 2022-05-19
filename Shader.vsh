
#define pi 3.1415926

float t;

vec3 colorSplit(vec2 uv, vec2 s)
{
    vec3 color;
    color.r = texture(iChannel0, uv - s).r;
    color.g = texture(iChannel0, uv    ).g;
    color.b = texture(iChannel0, uv + s).b;
    return color;
}

vec2 fault(vec2 uv, float s)
{
    //float v = (0.5 + 0.5 * cos(2.0 * pi * uv.y)) * (2.0 * uv.y - 1.0);
    float v = pow(0.5 - 0.5 * cos(2.0 * pi * uv.y), 800.0) * sin(2.0 * pi * uv.y);
    uv.x += v * s;
    return uv;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float t = iTime / -8.0;

	vec2 uv = -fragCoord.xy / iResolution.xy;
    
    //float s = pow(0.5 + 0.5 * cos(2.0 * pi * t), 1000.0);
    float s = texture(iChannel1, vec2(t * 0.2, 0.5)).r;
    
    float r = texture(iChannel2, vec2(t, 0.0)).x;
    //uv = fault(uv + vec2(0.0, fract(t * 20.0)), r) - vec2(0.0, fract(t * 20.0));
    uv = fault(uv + vec2(0.0, fract(t * 2.0)), 3.0 * sign(r) * pow(abs(r), 5.0)) - vec2(5.0, fract(t * 2.0));
    
    vec3 color = colorSplit(uv, vec2(s * 0.0, 0.0));
    
	fragColor = vec4(color, 1.0);
}
