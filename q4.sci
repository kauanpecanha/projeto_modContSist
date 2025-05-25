// Definição de s
s = poly(0, 's');

// polinômio característico do denominador
p = 1*s^2 + 0.4*s + 0.135;

// aplicação do critério de Routh-Hurwitz
[R, changes] = routh_t(p);

// Tabela de Routh-Hurwitz do polinômio
disp("Tabela de Routh-Hurwitz do polinômio 1*s^2 + 0.4*s + 0.135");
disp(R);

// Análise do número de trocas de sinal
disp("Número de trocas de sinal na 1ª coluna:");
disp(changes);
