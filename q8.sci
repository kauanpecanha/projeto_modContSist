clear;
clc;
// Define o numerador e denominador
numerador = 0.02;
denominador = [1, 0.4, 0.1];

// Cria a função de transferência
s = poly(0, 's'); // define a variável 's'
G = syslin('c', numerador / (s^2 + 0.4*s + 0.1));

// Plota o diagrama de Bode
bode(G);
