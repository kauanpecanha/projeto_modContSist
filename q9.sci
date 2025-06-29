clear;
clc;
// Define o numerador e o denominador
num = 0.02;
den = [1, 0.4, 0.1];

// Cria a função de transferência
s = poly(0, 's');
G = syslin('c', num / (s^2 + 0.4*s + 0.1));

// Nova figura
scf(1);
nyquist(G);
xgrid();
title('Nyquist com Polos');
plzr(G);
legend(['Nyquist', 'Polos']);
