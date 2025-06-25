clc;
clear;

// Define a variável de Laplace
s = %s;

// Define a função de transferência original
num = 0.02;
den = s^2 + 0.4*s + 0.1;
G = syslin('c', num, den);

disp("Função de Transferência Original:");
disp(G);

// Parâmetros da simulação
A = 10;                     // Amplitude do degrau de entrada
t_final = 30;               // Tempo final da simulação
pontos = 501;               // Número de pontos (resolução)
t = linspace(0, t_final, pontos); // Vetor de tempo
u = A * ones(t);            // Vetor de entrada (degrau)

// Simula a resposta ao degrau para obter os dados do "gráfico"
y = csim(u, t, G);

// =========================================================================
// PARTE 2: ALGORITMO DE IDENTIFICAÇÃO (MÉTODO GRÁFICO AUTOMATIZADO)
// =========================================================================
y_ss = y($); // Pega o último valor da resposta (regime permanente)
K_identificado = y_ss / A;
[y_pico, indice_pico] = max(y);
t_p = t(indice_pico);

// Calcula o sobressinal (Overshoot) como uma fração decimal
// Adiciona uma pequena tolerância para evitar divisão por zero se y_ss for 0
OS_decimal = (y_pico - y_ss) / y_ss;

// --- Etapa C: Calcular Zeta e Omega_n ---
disp(K_identificado);
