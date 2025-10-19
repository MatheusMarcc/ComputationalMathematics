function List1Exercise1() #main
 clc; #clean terminal
#inicializing values
 xU = 1.0;
 xI = 0.0;
 tol = 1e-5;
 max = 1000;
[dadosX, dadosY, dadosConv] = metodoDaBissecao(xI, xU, tol, max);
printf('Colunas do Graficos\n');
 for i = 1:length(dadosX)
  printf('X: %.6f', dadosX(i));
  printf(' Y: %.6f\n', dadosY(i));
 endfor
printf('Quantidade de iteracoes: %d\n', length(dadosX));
plotaGrafico(dadosX, dadosY, dadosConv, xI, xU, tol);
end
#calculate f(x)
function y = f(x)
  y = x.^3 + 2 .* x.^2 - 2;
end

#bissection method
function [dadosX, dadosY, dadosConv] = metodoDaBissecao(xI, xU, tol, max)
  dadosX    = zeros(1, max);
  dadosY    = zeros(1, max);
  dadosConv = zeros(1, max);
  xrVelho   = inf;

  for i = 1: max
   xR  = (xI + xU) / 2;
   fxR = f(xR);
   fxI = f(xI);
   fxu = f(xU);
   eA  = abs(xR - xrVelho);
   xrVelho      = xR;
   dadosX(i)    = xR;
   dadosY(i)    = fxR;
   dadosConv(i) = eA;

   if fxI .* fxR < 0
        xU = xR;
   elseif fxI .* fxR > 0
    xI = xR;
   elseif fxI .* fxR == 0
     dadosX = dadosX(1:i);
     dadosY = dadosY(1:i);
     break
   endif
   if eA < tol
      dadosX    = dadosX(1:i);
      dadosY    = dadosY(1:i);
      dadosConv = dadosConv(1:i);
      break
   endif
  endfor
end

#plot graph: bissection method and convergence
function plotaGrafico(dadosX, dadosY, dadosConv, xI, xU, tol)
  figure(1);
  qntFramesGrafico = length(dadosX);
  x = xI: 0.1: xU;
  for cont = 1:  qntFramesGrafico
   clf;
   p1 = plot(x, f(x), 'linewidth', 2, 'color', [0 0 1]);
   hold on;
   p2 = plot(dadosX(cont), dadosY(cont), 'linewidth', 1, 'color', [0 0 0], 'marker',
   'o', 'markersize', 5, 'markerfacecolor', [1 1 1]);
   set(gca, 'fontsize', 12);
   xlabel(sprintf('X = %.6f', dadosX(cont)));
   ylabel(sprintf('Y = %.6f', dadosY(cont)));
   legend([p1, p2], {'f(x) avaliada', ' raiz calculada'});
   title(sprintf('Grafico de f(x). Iteracoes ate convergir: %d', cont));
   grid on;
   pause(0.1);
  endfor
  figure(2)
  i = 1: length(dadosConv);
  e = plot(i, dadosConv, 'r-o', 'linewidth', 2, 'markersize', 2);
  title('Grafico de Convergencia');
  xlabel(sprintf('Iteracoes: %d', i(end)));
  ylabel('f(x)'), ;
  legend(e, {'Erro absoluto'});
  grid on;
 endfunction


