function genericOptimization()
  clc
  x0 = [0 2]';
  functions = @(x) [(2 * x(1) + x(2) - 5)^2 +  (x(1) + 2 * x(2) - 7)^2];
  grad = @(x) [10*x(1) + 8*x(2) - 34;
             8*x(1) + 10*x(2) - 38];
  H = [10, 8;
       8, 10];

  lim = 1000;
  tol = 1e-3;
  alpha = 0.045;

[dataXY, dataZ] = genericGradientDescent(x0, functions, grad, alpha, lim, tol);
printf(' Gradiente Descendente\n');
printf('==============================\n');
printf('X = [%.6f  %.6f]\n', dataXY(end,1), dataXY(end,2));
printf('f(X) = %.6f\n', dataZ(end));
printf('Iteracoes: %d', length(dataZ));
alpha = 1;

[dataXY2, dataZ2] = newthonMethod(x0, functions, grad, H, alpha, lim, tol);
printf('\n\n Metodo de Newton\n');
printf('==============================\n');
printf('X = [%.6f  %.6f]\n', dataXY2(end,1), dataXY2(end,2));
printf('f(X) = %.6f\n', dataZ2(end));
printf('Iteracoes: %d\n', length(dataXY2));


%plotConvergence(dataXY, dataZ); %convergencia do metodo do gradiente descendente
%plotConvergence(dataXY2, dataZ2); %convergencia do metodo de metodo de newthon
%genericPlot(dataXY, dataZ, functions); %animacao com o gradiente descendente
%genericPlot(dataXY2, dataZ2, functions); %animacao com o metodo de newton


end

function [dataXY, dataZ] = genericGradientDescent(x0, functions, grad, alpha, lim, tol)
    dataXY = zeros(lim + 1, length(x0));
    dataZ  = zeros(lim + 1, 1);
    dataXY(1, :) = x0;
    dataZ(1, :) = functions(x0);
    for i = 1 : lim
      x = x0 - alpha*grad(x0);
      dataXY(i + 1, :) = x;
      dataZ(i + 1, :) = functions(x);
      if max(abs(x- x0)) <= tol
          break
      endif
        x0 = x;
    endfor
    dataXY = dataXY(1:i+1, :);
    dataZ  = dataZ(1:i+1);
end

function [dataXY, dataZ] = newthonMethod(x0, functions, grad, H, alpha, lim, tol)
    dataXY = zeros(lim + 1, length(x0));
    dataZ  = zeros(lim + 1, 1);
    dataXY(1, :) = x0;
    dataZ(1, :) = functions(x0);
    for i = 1 : lim
      x = x0 - alpha* (H \ grad(x0));
      dataXY(i + 1, :) = x;
      dataZ(i + 1, :) = functions(x);
      if max(abs(x- x0)) <= tol
          break
      endif
        x0 = x;
    endfor
    dataXY = dataXY(1:i+1, :);
    dataZ  = dataZ(1:i+1);
 end

 function plotConvergence(dataXY, dataZ)
    figure(1);
    iterations = 1: length(dataZ);
    subplot(2, 1, 1);
    plot(iterations, dataXY, '-o', 'LineWidth', 2.0, 'MarkerSize', 6);
    xlabel('Iterations');
    ylabel('X values');
    grid on;

    subplot(2, 1, 2);
    plot(iterations, dataZ, '-o', 'LineWidth', 2.0, 'MarkerSize', 5);
    xlabel('Iterations');
    ylabel('F values');
    grid on;
 endfunction

function genericPlot(dataXY, dataZ, functions)

    x = linspace(-10, 10, 100);
    y = linspace(-10, 10, 100);
    [X, Y] = meshgrid(x, y);
    Z = zeros(size(X));

    for i = 1:length(x)
        for j = 1:length(y)
            Z(j, i) = functions([x(i); y(j)]);
        endfor
    endfor

    figure;
    surf(X, Y, Z);
    shading interp;
    colormap jet;
    view(50, 30);
    grid on;
    xlabel('x values');
    ylabel('y values');
    zlabel('z values');
    title('Superfície da Função');
    hold on;
    values = plot3(dataXY(1,1), dataXY(1,2), dataZ(1), ...
                   'o', 'MarkerFaceColor', 'r', 'MarkerSize', 5);
    for i = 1:length(dataZ) + 1
        set(values, 'XData', dataXY(i,1), ...
                    'YData', dataXY(i,2), ...
                    'ZData', dataZ(i));
        title(sprintf('Iterations: %d', i));
        drawnow;
        pause(0.8);
    endfor
endfunction

