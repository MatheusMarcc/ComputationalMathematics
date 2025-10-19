function List1Exercise2() # main
  xI = 0.0;
  xU = 1.0;
  max = 1000;
  tol = 1e-5;
  [dadosX, dadosY, dadosConv] = falsePositionMethod(xI, xU, max, tol);
  printf('X: %.6f:\n', dadosX(end));
  printf('Y: %.6f:\n', dadosY(end));
end

function y = f(x)
   y = x .^3 + 2 .* x .^2 - 2;
end

function [dadosX, dadosY, dadosConv] = falsePositionMethod(xI, xU, max, tol)
  dadosX    = zeros(1, max);
  dadosY    = zeros(1, max);
  dadosConv = zeros(1, max);
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
     dadosX(i)    = xr;
     dadosY(i)    = fxR;
     dadosConv(i) = eA;

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
     dadosX     = dadosX(1:i);
     dadosY     = dadosY(1:i);
     dadosConv  = dadosConv(1:i);
     break
    endif
  endfor
end
