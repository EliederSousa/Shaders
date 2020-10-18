

/**
 *  Light Attenuation
 *  
 *  Copyright (c) 2020, Elieder Sousa
 *  eliedersousa<at>gmail<dot>com
 *  
 *  Distributed under the MIT license.
 *  
 *  @date       18/10/20
 *  @brief      Teste com pontos de luz. Para detalhes, veja o link abaixo que contém a equação usada.
 *  @see        https://imdoingitwrong.wordpress.com/2011/01/31/light-attenuation/
 */
 
vec4 LightPoint( vec2 uv, vec2 pos, vec3 color, vec3 att ) {
	float dist = length ( pos - uv ) * 1.;
	float at = 1. / (att.x + att.y * dist + att.z * dist * dist );
	return vec4( at, at, at, 1. ) * vec4 ( color, 1. );
}

vec2 MousePosition() {
	return vec2((iMouse.x / iResolution.x) - .5, (iMouse.y / iResolution.y) - .5);
}

float rand(vec2 co){
	return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
	vec2 uv = fragCoord / iResolution.xy;
	uv -= .5;
	uv.x *= iResolution.x / iResolution.y;

	vec4 color = vec4(.0);      
	color += LightPoint( uv, vec2(0., 0.), vec3(1.0, 1.0, 1.0), vec3(0., 50., 500.) );
	color += LightPoint( uv, MousePosition(), vec3(.8, .7, .3), vec3(0., 100., 500.) );
    
	fragColor = color;
}
