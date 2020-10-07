/**
 *  Tutorial - circulo.glsl
 *  
 *  Copyright (c) 2020, Elieder Sousa
 *  
 *  Distributed under the MIT license.
 *  
 *  @date     07/10/20
 *  
 *  @brief      Meu primeiro shader. Este eu escrevi no Shader Editor (Android).
 */
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform float time;
uniform int pointerCount;
uniform vec3 pointers[10];
uniform vec2 resolution;

void main(void) {
    // Guarda o tamanho da tela (width, height)
    vec2 iResolution = vec2(resolution.x , resolution.y);
    // FragCoord  um vec2 que aponta pro pixel
    // Logo, essa diviso normaliza a entrada
    // Pois ao invs de trabalhar com a posio do
    // Pixel atual, trabalhamos com um intervalo fechado [0,1]
    vec2 uv = gl_FragCoord.xy / iResolution.xy;

    // uv  como o plano cartesiano; {0,0}  o canto inferior esquerdo
    // podemos fazer o centro do plano ser o centro da tela
    // Como uv.x ou .y vai de 0 a 1, basta subtrair .5 de x e y.
    uv -= .5;
    uv.x *= iResolution.x / iResolution.y;

    // O raio do crculo
    float radius = 0.2;
    // d ser a distncia da origem do plano {0,0} para o pixel atual
    // que no caso pode ser qualquer coisa entre -.5 e .5 (tanto x como y)
    float d = length(uv);
    // define a cor pela funo smoothstep.
    float c = smoothstep( radius, radius - .01, d);
    // Poderiamos desenhar um circulo assim tambm
    //if(d < 0.01) { c = 1.0; } else { c = 0.; }

    // Envia a cor para a tela.
    gl_FragColor = vec4(vec3(c), 1.0);
}
