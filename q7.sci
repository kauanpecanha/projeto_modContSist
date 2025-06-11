clear;
clc;
// Define o sistema em tempo contínuo (s)
s = poly(0, 's'); // define o polinômio s
G = syslin('c', 0.02 / (s^2 + 0.4*s + 0.1)); // função de transferência em malha aberta
// Plota o lugar das raízes
evans(G);
disp('Função de transferência em malha aberta: ', G);

// cálculo dos polos da função
expression = (s^2 + 0.4*s + 0.1);
coeffs = coeff(expression);
p = roots(coeffs);
disp("Pólos da função de transferência:", p);
