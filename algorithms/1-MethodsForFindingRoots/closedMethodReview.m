function closedMethodReview()
    clc;
    xi = 0.0;
    xu = 1.0;
    max = 1000;
    tol = 1e-5;
    %[dataX, dataY] = falsePositionMethod(xi, xu, max, tol);
    %[dataX, dataY] = bissectionMethod(xi, xu, max, tol);
    %dataX(end)
    %dataY(end)
    %plotGraph(dataX, dataY, xi, xu);


end



function y = f(x)

    y = x.^3 + 2.*x.^2 - 2;

end


function [dataX, dataY] = bissectionMethod(xi, xu, max, tol)

  dataX = zeros(1, max);
  dataY = zeros(1, max);
  oldXr = inf;

  for i = 1 : max

      %scalar variables
      xr = (xi + xu) / 2;
      fxr = f(xr);
      fxi = f(xi);
      fxu = f(xu);
      e = abs(xr - oldXr);
      oldXr = xr;

      %collections
      dataX(i) = xr;
      dataY(i) = fxr;

      if fxi .* fxr < 0
        xu = xr;
      elseif fxi .* fxr > 0
        xi = xr;
      endif

      if fxr == 0 || e <= tol
        break
      endif

  endfor
  dataX = dataX(1: i);
  dataY = dataY(1: i);
 end


function [dataX, dataY] = falsePositionMethod(xi, xu, max, tol)

  dataX = zeros(1, max);
  dataY = zeros(1, max);
  oldXr = inf;

  for i = 1: max

     %scalar variables
    fxi = f(xi);
    fxu = f(xu);
    xr = xu - (fxu .* (xi - xu)) / (fxi - fxu);
    fxr = f(xr);
    e = abs(xr - oldXr);
    oldXr = xr;

    %collections
    dataX(i) = xr;
    dataY(i) = fxr;

    if fxi .* fxr > 0
      xi = xr;
    else
      xu = xr;
    endif
    if e < tol
      break
    endif
  endfor

  dataX = dataX(1: i);
  dataY = dataY(1: i);

end

 function plotGraph(dataX, dataY, xi, xu)

    sizeXY = length(dataX);
    x       = xi : 0.1 : xu;
    figure(1);

    for i = 1 : sizeXY

      plot(x, f(x), 'linewidth', 1, 'MarkerFaceColor', 'b' , 'color', [0 0 1]);
      hold on
      subplot(3, 1, 1);

      plot(dataX(i), dataY(i), 'MarkerFaceColor', 'r', 'linewidth', 1, 'color', [0 0 0], 'marker', 'o');
      grid on;
      xlabel(' x avaliado');
      ylabel('valor de f(x) avaliado');
      title('Convergencia de x e f(x) no dominio');
      legend('f(x)');
      hold off;
      pause(0.5);
    endfor

    iter = 1: sizeXY;
    subplot(3, 1, 2);
    hold on;
    plot(iter, dataX, 'r-o', 'linewidth', 1, 'markersize', 1);
    xlabel('iteracoes');
    ylabel('x avaliado');
    title('Convergencia de x por iteracao');
    legend('valor de x');
    grid on;
    hold off;


    subplot(3, 1, 3);
    hold on;
    plot(iter, dataY, 'r-o', 'linewidth', 2 , 'markersize', 2);
    xlabel('iteracoes');
    ylabel('valor de f(x)');
    title('Convergencia de f(x) por iteracao');
    legend('Convergencia de f(x)');
    grid on;
    hold off;

 endfunction

