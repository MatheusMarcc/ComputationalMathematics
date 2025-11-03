function List1Exercise3()

  xL  = 1.0;
  xU  = 1.5;
  tol = 1e-5;
  max = 1000;
 [dataX, dataY] = bissectionMethod(xL, xU, tol, max);
  printf('X: %.6f\n', dataX(end));
  printf('Y: %.6f\n', dataY(end));
  printf('Iteracoes: %d\n', length(dataX));
  plotaGrafico(dataX, dataY, xL, xU);

end

function y = f(x)

  y = x .^3 - 2 .* x .^2 + x - 0.275;

end


function [dataX, dataY] = bissectionMethod(xL, xU, tol, max)

 dataX = zeros(1, max);
 dataY = zeros(1, max);
 oldXr = inf;

  for i = 1:max
   xr = (xU + xL) / 2;
   fxr = f(xr);
   fxL = f(xL);
   fxU = f(xU);
   eA = abs(xr - oldXr);

   dataX(i) = xr;
   dataY(i) =  fxr;
   oldXr = xr;
   if fxr .* fxL < 0
      xU = xr;
   elseif fxr .* fxL > 0
      xL = xr;
   elseif fxr .* fxL == 0
      dataX = dataX(1: i);
      dataY = dataY(1: i);
      break;
   endif
   if eA < tol
      dataX = dataX(1: i);
      dataY = dataY(1: i);
      break;
   endif
  endfor
end


function plotaGrafico(dataX, dataY, xL, xU)

 x = xL:0.1:xU;
 for cont  = 1 : length(dataX);
   clf;
   p1 = plot(x, f(x));
   hold on

   p2 = plot(dataX(cont), dataY(cont), 'linewidth', 1, 'color', [0 1 0.5],
   'marker', 'o', 'markersize', 5, 'markerfacecolor', [1 1 1]);

 endfor


end
