function List1Exercise1()
 clc;
 xU = 1.0;
 xI = 0.0;
 tol = 1e-5;
 max = 1000;
[dadosX, dadosY, i] = metodoDaBissecao(xI, xU, tol, max);
printf('X: %.6f\n', dadosX(end));
printf('Y: %.6f\n', dadosY(end));
printf('Quantidade de iteracoes: %d\n', i);
plotaGrafico(dadosX, dadosY);
end

function y = f(x)
  y = x.^3 + 2 .* x.^2 - 2;
end

function [dadosX, dadosY, i] = metodoDaBissecao(xI, xU, tol, max)
  dadosX = zeros(1, max);
  dadosY = zeros(1, max);
  xrVelho = inf;
  for i = 1: max
   xR = (xI + xU) / 2;
   if f(xI) .* f(xR) < 0
        xU = xR;
   #elseif f(xI) .* f(xR) > 0
    #xI = xR;
   #elseif f(xI) .* f(xR) == 0
    # dadosX(i) = xR;
     #dadosY(i) = f(xR);
     #dadosX = dadosX(1:i);
     #dadosY = dadosY(1:i);
     #break
   #endif
   if abs(xR - xrVelho) < tol
      dadosX(i) = xR;
      dadosY(i) = f(xR);
      dadosX = dadosX(1:i);
      dadosY = dadosY(1:i);
      break
   endif
   xrVelho = xR;
   dadosX(i) = xR;
   dadosY(i) = f(xR);
  endfor
end

function plotaGrafico(dadosX, dadosY)

  figure(1);
  qntFramesGrafico = length(dadosX);
  x = 0.0: 0.1: 1.0;
  for cont = 1:  qntFramesGrafico
   clf;
   p1 = plot(x, f(x), 'linewidth', 2, 'color', [0 0 1]);
   hold on;
   p2 = plot(dadosX(cont), dadosY(cont), 'linewidth', 1, 'color', [0 0 0], 'marker',
   'o', 'markersize', 10, 'markerfacecolor', [1 1 1]);
   set(gca, 'fontsize', 12);
   xlabel(sprintf('X = %.6f', dadosX(cont)));
   ylabel(sprintf('Y = %.6f', dadosY(cont)));
   legend([p1, p2], {'f(x) avaliada', ' raiz calculada'});
   title(sprintf('Grafico de f(x). Iteracoes ate convergir: %d', cont));
   grid on;
   pause(0.2);

  endfor

 endfunction


