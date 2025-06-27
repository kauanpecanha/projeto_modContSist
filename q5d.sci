// Definição de s
s = poly(0, 's');

// polinômio característico do denominador
p = 8.33*s^3+4.33*s^2 + 1.23*s + 0.77;

// aplicação do critério de Routh-Hurwitz
[R, changes] = routh_t(p);

// Tabela de Routh-Hurwitz do polinômio
disp("Tabela de Routh-Hurwitz do polinômio 8.33*S^3+4.33*s^2 + 1.23*s + 0.43");
disp(R);

// Análise do número de trocas de sinal
disp("Número de trocas de sinal na 1ª coluna:");
disp(changes);
