clc
clear

// ParamResposta : calcula os parâmetros da resposta dos sistemas de 2da ordem
// [tp,po,ymax,yss] = ParamResposta(t,y)
//
// onde : y : vetor contendo as repostas correspondentes
// aos instantes de simulacao armazenados no
// vetor t
// t : vetor contendo os instantes de simulacao
// tp : tempo de pico
// po : percentual de ultapassagem
// ymax : valor maximo da resposta
// yinf : valor de estado permanente da
//
function [tr,tp,po,ymax,yinf,ts] = ParamResposta(t,y)
    [ymax,i]=max(y);
    tp=t(i);
    
    yinf=y($); // estado permanente
    
    po=(ymax-yinf)/yinf*100;
    
    r=1;
    while y(r)<yinf; r=r+1; end;
    tr=t(r);
    
    r=length(y);
    while y(r)>0.98*yinf & y(r)<1.02*yinf; r=r-1; end;
    ts=t(r-1);
    
    mprintf("tr = %.2f, tp = %.2f, po = %.2f%%, ymax = %.2f, yinf = %.2f, ts = %.2f\n", tr, tp, po, ymax, yinf, ts);

endfunction

function A = f(t,x)
    A = [x(2);(1/m)*((-c)*x(2) + (-k)*(x(1)))];
endfunction

// Intervalo de tempo
t0 = 0;
tf = 50;
t = linspace(t0, tf, 1000);

// Parâmetros do sistema
m = 50;
c = 20;
k = 5;

// Caso 1
x0_1 = [0; m/2];
x1 = ode(x0_1, t0, t, f);
disp("Caso 1:");
[tr1, tp1, po1, ymax1, yinf1, ts1] = ParamResposta(t, x1(1,:));

// Caso 2
x0_2 = [m/4; 0];
x2 = ode(x0_2, t0, t, f);
disp("Caso 2:");
[tr2, tp2, po2, ymax2, yinf2, ts2] = ParamResposta(t, x2(1,:));

// Caso 3
x0_3 = [m/5; m/3];
x3 = ode(x0_3, t0, t, f);
disp("Caso 3:");
[tr3, tp3, po3, ymax3, yinf3, ts3] = ParamResposta(t, x3(1,:));

// Caso 4
x0_4 = [0; 0];
x4 = ode(x0_4, t0, t, f);
disp("Caso 4:");
[tr4, tp4, po4, ymax4, yinf4, ts4] = ParamResposta(t, x4(1,:));

// Plot
clf();
scf(0);
subplot(3,1,1);
plot(t, x2(1,:), '-g');
xtitle("Caso 2: X0 = 12.5, V0 = 0", "Tempo (s)", "Posição (m)");
xgrid(1,1,3);

subplot(3,1,2);
plot(t, x3(1,:), '-r');
xtitle("Caso 3: X0 = 10, V0 = 16.67", "Tempo (s)", "Posição (m)");
xgrid(1,1,3);

subplot(3,1,3);
plot(t, x4(1,:), '-r');
xtitle("Caso 4: X0 = 0, V0 = 0", "Tempo (s)", "Posição (m)");
xgrid(1,1,3);
