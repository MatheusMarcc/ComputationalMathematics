function List2Exercise4
  x0 = [1, 1];
  x0 = x0';
  max = 1000;
  tol = 1e-5;
  [dadosX, dadosFx] = newthonRaphsonMethod(x0, max, tol);
for i = 1:length(dadosX)
  printf('Iteração %d:\n', i);
  printf('  Raiz de X: %.6f  ', dadosX(i, 1));
  printf('Raiz de Y: %.6f\n', dadosX(i, 2));
  printf('  f(x, y): %.6f  ', dadosFx(i, 1));
  printf('g(x, y): %.6f\n\n', dadosFx(i, 2));
endfor

  plotaGrafico(dadosX, dadosFx);

end

function fxy = f(x0)
  x = x0(1);
  y = x0(2);
  fxy = x + y - sqrt(y) -0.25;
end

function gxy = g(x0)
  x = x0(1);
  y = x0(2);
  gxy = 8 .* x .^2 + 16 .*y - 8 .*x .*y - 10;
end

function dfx = dfx()
  dfx = 1;
end

function dfxy = dfy(x0)
  y = x0(2);
  dfxy = 1 - 1 / (2 .* sqrt(y));
end

function dgxy = dgx(x0)
  x = x0(1);
  y = x0(2);
  dgxy = 16 .* x - 8 .* y;
end

function dgxy = dgy(x0)
  x = x0(1);
  dgxy = 16 - 8 .* x;
end

function jacobianoInverso = j(x0)
 matrix = [dfx(), dfy(x0); dgx(x0), dgy(x0)];
 jacobianoInverso = matrix^(-1);
end

function [dadosX, dadosFx] = newthonRaphsonMethod(x00, maxI, tol)
  x0 = x00;
  dadosX =  zeros(maxI + 1, length(x0));
  dadosFx = zeros(maxI + 1, 2);
  dadosX (1, :) = x0;
  dadosFx(1, :) = [f(x0), g(x0)];
  for i = 1: maxI
   fx0 = f(x0);
   gx0 = g(x0);
   vecF = [fx0; gx0];
   x1 = x0 - j(x0) * vecF;
   dadosX (i + 1, :)  = x1';
   dadosFx(i + 1,:) = [fx0, gx0];
   if max(abs(x0 - x1)) <= tol
      dadosX  =  dadosX(1: i + 1, :);
      dadosFx = dadosFx(1: i + 1, :);
      break
   endif
   x0 = x1;
  end

end

function plotaGrafico(dadosX, dadosFx)
  figure;
  i = 1: length(dadosX);
  subplot(2, 1, 1);
  hold on;
  plot(i, dadosX(:, 1), '-o', 'LineWidth', 1, 'MarkerFaceColor', 'b');
  plot(i, dadosX(:, 2), '-o', 'LineWidth', 1, 'MarkerFaceColor', 'r');
  xlabel('iteracoes');
  ylabel('x e y calculados');
  title('Grafico de Convergencia de x e y');
  legend('X', 'Y');
  grid on;
  hold off;

  subplot(2, 1, 2);
  hold on;
  plot(i, dadosFx(:, 1), '-o', 'LineWidth', 1, 'MarkerFaceColor', 'b');
  plot(i, dadosFx(:, 2), '-o', 'LineWidth', 1, 'MarkerFaceColor', 'r');
  xlabel('iteracoes');
  ylabel('f(x, y) e g(x, y)');
  title('Grafico de Convergencia de f e g');
  legend('F', 'G');
  grid on;
  hold off;
end



