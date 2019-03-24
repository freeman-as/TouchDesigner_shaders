// LICENSE:
// Creative Commons Attribution 4.0 International License.
// https://creativecommons.org/licenses/by/4.0/

#define T(x) texture(iChannel0, fract((x)/iResolution.xy))

void mainImage(out vec4 c, vec2 u)
{   
    //c=1./u.yyyx;
    c=u.yyyx/1e4;///iTime;
    //for(float t=1.4; t<1e2; t+=t)
    //    c += (c.gbar-c)/3.+T(u-c.wz*t);
    for(float t=.6; t<4e2; t+=t)
    	c += c.gbar/4.-c*.3+T(u-c.wz*t);
    
	c = mix(T(u+c.xy), cos(c), .07);
}