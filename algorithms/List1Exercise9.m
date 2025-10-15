function List1Exercise9()
 # inicializando os valores
 xI  = 2.5;
 xU  = 5.5;
 eA = 0.1;
 cont = 0;
 max = 1000;
 tolerancia = 1 * 10^-5;
 #chamada da funcao que lida com tudo
 [dadosX, dadosY] = calculaValores(xI, xU, eA, cont, max, tolerancia);
 #printf("Valor de x: %0.5f", x);
 #printf("Valor de y: %0.5f", y);
 plotaGrafico(dadosX, dadosY);

end
# calcula a funcao dada
function y = f(x)
  y = sin(x/2) .* (x - 9/2) .* (x + 29);
end
# calcula a raiz com o metodo
 function xr = metodoDaFalsaPosicao(xI, xU)
  fxI = f(xI);
  fxU = f(xU);
  xr = xU - (fxU * (xI - xU)) / (fxI - fxU);
 end

# calcula o erro
function eA = calculaEpsilon(xrNovo, xrVelho)
 eA = abs((xrNovo - xrVelho) / xrNovo) * 100;
end

# calcula os valores extraidos
function [dadosX, dadosY] = calculaValores(xI, xU, eA, cont, max, tolerancia)
  xR = 0;
  dadosX = [];
  dadosY = [];
  while  eA > tolerancia && cont < max
    cont = cont + 1;
    xrVelho = xR;
    fxI = f(xI);
    fxU = f(xU);
    xR  = metodoDaFalsaPosicao(xI, xU);
    fxR = f(xR);
    dadosX(end + 1) = xR;
    dadosY(end + 1) = fxR;
    if fxI * fxR < 0
     xI = xR;
    else
     xU = xR;
    endif
    eA = calculaEpsilon(xR, xrVelho);
   end
    x   = xR;
    y   = fxR;
    quant = cont;
 end


 function grafico = plotaGrafico(dadosX, dadosY)

    x = 2.5:0.1:5.5;
    plot(x, f(x));
    xlabel("Eixo x");
    ylabel("Eixo y");
    grid on;
    title("Teste gráfico 2D");
    hold on;
    for i = 2:length(dadosX)
        plot(dadosX(i-1:i), dadosY(i-1:i));
        pause(0.1);
    end


 endfunction

