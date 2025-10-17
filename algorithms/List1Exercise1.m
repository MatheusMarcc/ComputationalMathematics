function List1Exercise1()
 xU = 0.0;
 xI = 1.0;
 tol = 1e-5;
 max = 1000;

end

function y = f(x)
  y = x^3 + 2 .* x^2 - 2;
end

function [dadosX, dadosY] = metodoDaBissecao(xI, xU, tol, max)
  dadosX = zeros(1: max);
  dadosY = zeros(1: max);
  for i = 1: max;
   xR = (xI + xU) / 2;
   if f(xI) .* f(xR) < 0
    xU = xR;
   elseif f(xI) .* f(xR) > 0
    xI = xR;
   else
    dadosX(i) = xR;
    dadosY(i) = f(xR);
     break
   endif
   dadosX(i) = xR;
   dadosY(i) = f(xR);
  endfor


end


