// Sistema real
num = 0.02;
den = [1, 0.4, 0.1];
sys_real = syslin('c', num, den);

// Tempo de simulação
t = 0:0.1:100;

// Resposta ao degrau do sistema real
[y_real, t] = csim('step', t, sys_real);

// Valor final da saída (ganho DC)
y_final = num / den($);

// Pico da resposta
y_peak = max(y_real);

// Overshoot (Mp)
Mp = (y_peak - y_final) / y_final;

// Tempo de pico (tp)
[y_peak, idx_peak] = max(y_real);
tp = t(idx_peak);

// Fator de amortecimento (xi)
xi = -log(Mp) / sqrt(%pi^2 + (log(Mp))^2);

// Frequência natural (wn)
wn = %pi / (tp * sqrt(1 - xi^2));

// Sistema identificado (sem ganho ainda)
num_id = [wn^2]; // Certifica que seja vetor
den_id = [1, 2*xi*wn, wn^2];

K = y_final;
num_id_scaled = [K * wn^2]; // Também vetor

sys_id = syslin('c', num_id_scaled, den_id);


// Resposta ao degrau do sistema identificado
[y_id, t_id] = csim('step', t, sys_id);

// Plot das respostas
clf();
plot(t, y_real, 'r', t, y_id, 'b--');
legend('Sistema Real', 'Sistema Identificado');
xlabel('Tempo (s)');
ylabel('Saída');
title('Resposta ao Degrau: Real vs Identificado');
xgrid();

// Cálculo do Erro Médio Quadrático (MSE)
mse = mean((y_real - y_id).^2);
disp("Erro Médio Quadrático (MSE) = " + string(mse));
