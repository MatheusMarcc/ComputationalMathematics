function List1Exercise2() # main
  xI = 0.0;
  xU = 1.0;
  max = 1000;
  tol = 1e-5;
  [dataX, dataY] = falsePositionMethod(xI, xU, max, tol);
  printf('X: %.6f:\n', dataX(end));
  printf('Y: %.6f:\n', dataY(end));
  plotaGrafico(dataX, dataY, xI, xU);
end

function y = f(x)
   y = x .^3 + 2 .* x .^2 - 2;
end

function [dataX, dataY] = falsePositionMethod(xI, xU, max, tol)
  dataX    = zeros(1, max);
  dataY    = zeros(1, max);
  xrVelho = inf;
  contI = 0;
  contU = 0;

  for i = 1:max
     fxI = f(xI);
     fxU = f(xU);
     xr  = xU - (fxU * (xI - xU)) / (fxI - fxU);
     fxR = f(xr);
     eA  = abs(xr - xrVelho);
     xrVelho = xr;
     dataX(i)    = xr;
     dataY(i)    = fxR;

     if fxR * fxI > 0
       xI = xr;
       contI += 1;
       contU  = 0;
       if contI > 1
        fxI = fxI / 2;
       endif
     else
       xU = xr;
       contU += 1;
       contI  = 0;
       if contU > 1
          fxU = fxU / 2;
       endif
     endif

    if eA < tol
     dataX  = dataX(1:i);
     dataY  = dataY(1:i);
     break
    endif
  endfor
end

function plotaGrafico(dataX, dataY, xI, xU, tol)
  x = xI : 0.1 : xU;
  figure(1);
  for i = 1 : length(dataX)
   clf;
   p1 = plot(x, f(x), 'linewidth', 2, 'color', [0.5 0.2 0.1]);
   hold on;
   p2 = plot(dataX(i), dataY(i), 'linewidth', 1, 'color', [0 0 0], 'marker',
   'o', 'markersize', 5, 'markerfacecolor', [1 1 1]);
   xlabel(sprintf('xR: %.6f', dataX(i)));
   ylabel(sprintf('f(xR): %.6f', dataY(i)));
   title('Grafico de convergencia de f(xR)');
   legend([p1, p2], {'f(x)', 'valor de f(xr)'});
   grid on;
   pause(0.1)
  endfor
  figure(2);
  j = 1: length(dataX);
  pXr = plot(j, dataX, 'r-o', 'linewidth', 2, 'markersize', 2);
  xlabel('iteracao');
  ylabel('valor de xR');
  title('grafico de convergencia de xr');
  legend(pXr, {'valor de xR ao longo do tempo'});
  grid on;

  figure(3);
  pFxr = plot(j, dataY, 'r-o', 'linewidth', 2, 'markersize', 2, 'color', [0 0.5 1]);
  xlabel('iteracao');
  ylabel('valor de f(xr)');
  title('Grafico de convergencia de f(xr)');
  legend(pFxr, {'valor de f(x) ao longo do tempo'});
  grid on;

end

