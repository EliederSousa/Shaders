/**
 *  Plano Cartesiano e círculos.glsl
 *  
 *  Copyright (c) 2020, Elieder Sousa
 *  eliedersousa<at>gmail<dot>com
 *  
 *  Distributed under the MIT license.
 *  
 *  @date       16/10/20
 *  @brief      Aqui eu mostro como criar um plano cartesiano no Shadertoy.
 *  
 */ 

// Variáveis globais.
const float smoothFactor = .008;

float Circle( vec2 uv, vec2 pos, float radius) {
    
    // Fazemos a translação da coordenada para calcular com base na posição
    // Alargamos o plano multiplicando pelo tamanho
    // E calculamos a distância do nosso ponto até o centro do eixo 
    //uv -= pos;
    //float dist = length( uv );
    
    // Porém, assim é melhor:
    float dist = length( uv - pos );
    
    // Este if abaixo é praticamente a mesma coisa que:
    // dist = smoothstep( radius, radius - 0.00000001 , dist );
    
    /*if( dist < radius ) {
        dist = 1.;
    } else {
        dist = 0.;
    }*/
    
    // smothstep( min, max, input );
    // Se dist for menor que radius, retorna 0.
    // Se dist for maior que radius + smoothFactor, retorna 1.
    // Qualquer valor entre radius e radius + smoothFactor retorna uma curva suave
    
    // Se fizessemos dist = smoothstep( radius, radius + smoothFactor, dist );
    // Ficaria errado, pois a função pintaria toda a parte de fora de branco
    // Isso cancelaria qualquer outra manipulação de cor que fizessemos depois disso
 	dist = smoothstep( radius, radius - smoothFactor, dist );
    return dist;    
}

// Cria uma linha na posição especificada
// LineDebug( uv.x , .4 );
float LineDebug( float axis, float pos ) {
    float blur = .002;
    float bias = pos + .004;
 	float l1 = smoothstep( pos - blur, pos + blur, axis);
    float l2 = smoothstep( bias + blur, bias - blur, axis);
    
    return l1 * l2;
}

float PlanoCartesiano( vec2 uv, vec2 center ) {
    float c = LineDebug( uv.y, center.x );
    c += LineDebug( uv.x, center.y );
    return c;
}

// Lembre-se:
// fragColor é a cor final do pixel: vec4( red, green, blue, alpha );
// fragCoord é a coordenada do pixel que está sendo processado no momento: vec2(x, y);
// iResolution é o tamanho da nossa tela: vec2( width, height );
void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    
    // Setup da nossa tela de desenho.
    vec2 uv = fragCoord / iResolution.xy; 	// Normalização
    uv -= .5; 								// Centralização do eixo de coordenadas
    uv.x *= iResolution.x / iResolution.y; 	// Aspect-Ratio
    
    // Declaração de variáveis e vetores.
    vec3 color = vec3( 0. );
    
    // Desenha alguns círculos.
   	color += vec3(Circle(uv, vec2(.3,.3), .1), .0, .0);
  	color += vec3(.0, Circle(uv, vec2(.0,-.3), .05), .0);
    color += vec3(.0, .0, Circle(uv, vec2(-.7,.1), .25));
    
    // Desenha o nosso plano cartesiano.
    color += PlanoCartesiano( uv, vec2(.0, .0)) * .4;
    
    // Retorna qual cor este pixel deve ter.
    fragColor = vec4( color, 1. );
    
}