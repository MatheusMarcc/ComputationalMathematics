function genericNewtonRaphson()
clc;
x   = [1, 1]';
max = 1000;
tol = 1e-5;
%functions
f = @(x) x(1) + x(2) - sqrt(x(2)) -0.25;
g = @(x) 8 .* x(1) .^2 + 16 .*x(2) - 8 .*x(1) .*x(2) - 10;

functions = @(x) [f(x); g(x)];
jInv = @(x)inv([  1, 1 - 1 / (2 .* sqrt(x(2))); 16 .* x(1) - 8 .* x(2),  16 - 8 .* x(1)]);

%atribuition
functions(x);
jInv(x);

%test
[data, dataF] = newtonRaphson(x, functions, jInv, max, tol);

%print
  for i = 1: length(data(1,:))
    printf('Values of x%d: %.4f\n', i, data(end, i));
  endfor
  printf('\n');
  for i = 1: length(data(1,:))
    printf('Values of F%d:  %.4f\n', i, dataF(end, i));
  endfor
%plot
 genericPlot(data, dataF);
end

function [data, dataF] = newtonRaphson(x0, functions, jInv, maxI, tol)
  data  = zeros(maxI + 1, length(x0));
  dataF = zeros(maxI + 1, length(x0));
  data(1,  :) = x0;
  dataF(1, :) = functions(x0);
  for i = 1 : maxI
    x = x0 - jInv(x0) * functions(x0);
    data(i + 1, :)  = x;
    dataF(i + 1, :) = functions(x);
    if max(abs(x0 - x)) <= tol
     break
    endif
    x0 = x;
  endfor
  data  = data (1: i + 1, :);
  dataF = dataF(1: i + 1, :);
end

function genericPlot(data, dataF)
   numIter = size(data, 1);
   numV = size(data, 2);
   i = 1: numIter

   subplot(2, 1, 1);
   hold on;
   plot(i, data(:, :), '-o', 'LineWidth', 1, 'MarkerFaceColor', 'b');
   xlabel('iteracoes');
   ylabel('valores das variaveis');
   legData = arrayfun(@(k) sprintf('x%d', k), 1:numV, 'UniformOutput', false);
   legend(legData(:));
   title('Grafico de convergencia das variaveis');
   grid on;
   hold off;

   subplot(2, 1, 2);
   hold on;
   plot(i, dataF(:, :), '-o', 'LineWidth', 1, 'MarkerFaceColor', 'r');
   xlabel('iteracoes');
   ylabel('valores das funcoes');
   legDataF = arrayfun(@(k) sprintf('F%d', k), 1:numV, 'UniformOutput', false);
   legend(legDataF(:));
   title('Grafico de convergnecia das funcoes');
   grid on;
   hold off;
 end
