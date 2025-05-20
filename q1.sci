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
    // calculando o ponto de maximo e o instante onde o maximo ocorre:
    [ymax,i]=max(y);
    tp=t(i);
    ////disp(tp)
    // calculando o valor de estado permanente:
    yinf=y(size(y,2))
    ////disp(yinf)
    // calculando o percentual de ultrapassagem:
    po=(ymax-yinf)/yinf*100
    ////disp(po)
    //calculando o tempo de subida ts
    r=1;
    while y(r)<yinf; r=r+1; end;
    tr=t(r);
    ////disp(tr)
    //calculando o tempo de estabelecimento 2//
    r=size(y,2);
    while y(r)>0.98*yinf & y(r)<1.02*yinf; r=r-1; end;
    ts=t(r-1)
    ////disp(ts)
endfunction

function A = f(t,x)
    // vetor sistema transformado para primeira ordem
    A = [x(2);(1/m)*((-c)*x(2) + (-k)*(x(1)))]
endfunction

// Intervalo de tempo
t0 = 0;
tf = 50;
t = linspace(t0, tf, 1000);
// Parâmetros do sistema
m = 50;
c = 20;
k = 5;

// Caso 1: Velocidade = m/2, Posição = 0
x0_1 = [0; m/2]; // [posição; velocidade]
x1 = ode(x0_1, t0, t, f);

// Caso 2: Velocidade = 0, Posição = m/4
x0_2 = [m/4; 0];
x2 = ode(x0_2, t0, t, f);

// Caso 3: Velocidade = m/3, Posição = m/5
x0_3 = [m/5; m/3];
x3 = ode(x0_3, t0, t, f);

// Plotando os gráficos
clf();
scf(0);
subplot(3,1,1);
plot(t, x1(1,:), '-b');
xtitle("Caso 1: X0 = 0, V0 = m/2", "Tempo (s)", "Posição (m)");
xgrid(1,1,3);

subplot(3,1,2);
plot(t, x2(1,:), '-g');
xtitle("Caso 2: X0 = m/4, V0 = 0", "Tempo (s)", "Posição (m)");
xgrid(1,1,3);

subplot(3,1,3);
plot(t, x3(1,:), '-r');
xtitle("Caso 3: X0 = m/5, V0 = m/3", "Tempo (s)", "Posição (m)");
xgrid(1,1,3);
