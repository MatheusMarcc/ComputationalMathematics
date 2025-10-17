function List1Exercise9() #main
  clc;
 #Initializing values
  xI   = 2.5;
  xU   = 5.5;
  cont = 0;
  max  = 1000;
  tol = 1e-5;
  [dadosX, dadosY, i] = metodoDaFalsaPosicao(xI, xU, max, tol);
  printf('Colunas do grafico:');
  for i = 1:length(dadosX)
   printf('\nX = %.6f', dadosX(i));
   printf('  Y = %.6f', dadosY(i));
  endfor
  printf('\nQuantidade de iteracoes necessarias: %d\n', i);
  plotaGrafico(dadosX, dadosY);
endfunction

#Calculate f(X)
function y = f(x)
  y = sin(x/2) .* (x - 9/2) .* (x + 29);
endfunction

#False position method
function [dadosX, dadosY, i] = metodoDaFalsaPosicao(xI, xU, max, tol)
  dadosX = zeros(1, max);
  dadosY = zeros(1, max);
  xrVelho = inf;
  contU = 0;
  contI = 0;
  for i = 1: max
   fxI = f(xI);
   fxU = f(xU);
   xR = xU - (fxU * (xI - xU)) / (fxI - fxU);
   fxR = f(xR);
   dadosX(i) = xR;
   dadosY(i) = fxR;
    if fxI * fxR > 0
       xI = xR;
       contU = 0;
       contI += 1;
       if contI > 1
         fxI = fxI / 2; #if xI stuck, force to reduce itself
       endif
     else
       xU = xR;
       contI = 0;
       contU += 1;
        if contU > 1
         fxU = fxU / 2; #if xU stuck, force to reduce itself
        endif
     endif
    if abs(xrVelho - xR) <= tol
      dadosX = dadosX(1:i);
      dadosY = dadosY(1:i); #remove empty spaces by truncating the vector
      break;
    endif
    xrVelho = xR;
  endfor

endfunction

# Show the graph of f(x) and tangent lines of the false position method
function plotaGrafico(dadosX, dadosY)
  figure(1);
  qtdeFramesG = length(dadosX);
  x = 2.5:0.1:5.5;
  for cont = 1: qtdeFramesG
   clf;
   p1 = plot(x, f(x), 'linewidth', 2, 'color', [0 0 1]);
   hold on;
   p2 = plot(dadosX(cont), dadosY(cont), 'linewidth', 1, 'color', [0 0 0], 'marker',
   'o', 'markersize', 10, 'markerfacecolor', [1 1 1]);
   set(gca, 'fontsize', 12);
   xlabel(sprintf('Xr = %.6f', dadosX(cont)));
   ylabel(sprintf('f(xr) = %.6f', dadosY(cont)));
   legend([p1, p2], {'f(x) avaliada', 'raiz calculada'});
   title(sprintf('Grafico de convergencia. Iteracoes =  %d', cont));
   grid on;
   pause(0.5);
  endfor
endfunction
