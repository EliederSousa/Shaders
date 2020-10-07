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
    // FragCoord é um vec2 que aponta para o pixel
    // Logo, essa divisão normaliza a entrada pois ao invés de trabalhar com a posição do pixel atual, trabalhamos com um intervalo fechado [0,1]
    vec2 uv = gl_FragCoord.xy / iResolution.xy;

    // uv é como o plano cartesiano; {0,0} é o canto inferior esquerdo. Podemos fazer o centro do plano ser o centro da tela.
    // Como uv.x ou .y vai de 0 a 1, basta subtrair .5 de x e y.
    uv -= .5;
    // Aqui, acertamos o aspect ratio (pois telas diferentes tem tamanhos de largura diferentes da altura).
    uv.x *= iResolution.x / iResolution.y;

    // O raio do círculo
    float radius = 0.2;
    // d é a distância da origem do plano {0,0} para o pixel atual que no caso pode ser qualquer coisa entre -.5 e .5 (tanto x como y)
    float d = length(uv);
    // Define a cor pela funo smoothstep.
    float c = smoothstep( radius, radius - .01, d);
    // Poderíamos desenhar um circulo assim também
    //if(d < 0.01) { c = 1.0; } else { c = 0.; }

    // Envia a cor para a tela.
    gl_FragColor = vec4(vec3(c), 1.0);
}
