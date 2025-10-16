function List1Exercise9()
  clc;
  # inicializando os valores
  xI   = 2.5;
  xU   = 5.5;
  cont = 0;
  max  = 1000;
  tol = 1e-5;
  # Function that calculates the roots
  [dadosX, dadosY, xR, fxR, i] = metodoDaFalsaPosicao(xI, xU, max, tol);
  printf("Valor da raiz: %.6f", xR);
  printf("\nValor de Y na raiz: %.6f", fxR);
  printf("\nQuantidade de iteracoes necessarias: %d\n", i);
  plotaGrafico(dadosX, dadosY);
endfunction

# Calculate f(X)
function y = f(x)
  y = sin(x/2) .* (x - 9/2) .* (x + 29);
endfunction

# False position method
function [dadosX, dadosY, xR, fxR, i] = metodoDaFalsaPosicao(xI, xU, max, tol)
  dadosX = zeros(1, max);
  dadosY = zeros(1, max);
  xrVelho = inf;
  for i = 1: max
   fxI = f(xI);
   fxU = f(xU);
   xR = xU - (fxU * (xI - xU)) / (fxI - fxU);
   fxR = f(xR);
   dadosX(i) = xR;
   dadosY(i) = fxR;
    if fxI * fxR < 0
       xI = xR;
     else
       xU = xR;
     endif
    if abs(xrVelho - xR) <= tol
      dadosX = dadosX(1:i);
      dadosY = dadosY(1:i); #trunco os vetores
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
   p1 = plot(x, f(x));
   hold on;
   p2 = plot(dadosX(cont), dadosY(cont), 'linewidth', 1, 'color', [0 0 0], 'marker',
   'o', 'markersize', 10, 'markerfacecolor', [1 1 1]);
   #hold off;
   set(gca, 'fontsize', 20);
   xlabel('xR');
   ylabel('fxR');
   legend([p1, p2], {'f(x) avaliada', 'raiz calculada'});
   title(sprintf('Iteracao %d. Valor da raiz: %.6f', cont, dadosY(cont)));
   grid on;
   pause(0.001);
  endfor
endfunction
