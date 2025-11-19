function list3Exercise13()
A = [ 2 0 1  ;
       5 -1 1 ;
     - 1 2 2  ;];

B = [2; 5; 0;];


 M = [A B];
 %impressao personalizada do sistema em questao
 printf('Sistema linear a ser solucionado: \n\n');
 for i = 1: size(M, 1)
    for j = 1 : size(M, 1) + 1
      if j ~= (size(M, 1) + 1) && (j + 1) ~= size(M, 1) + 1 && M(i, j + 1) >= 0
          printf('%.2fx%d +  ', M(i, j), j);
      elseif j + 1 == (size(M, 1) + 1)
          printf('%.2fx%d = %2.f', M(i, j), j, M(i, j + 1));
     elseif j ~= (size(M, 1) + 1) && (j + 1) ~= size(M, 1) + 1 && M(i, j + 1) < 0
        printf('%.2fx%d ', M(i, j), j);
     end
    endfor
    printf('\n');
 endfor
 M = pivotamento(M);
 printf('Solucao: \n\n');
 M = partialGaussJordan(M);
 M = M'

end

function pivotada = pivotamento(M)

 tam = size(M, 1);
  for i = 1: tam
   temp = M(i, :);
   [k, j] = max(abs(M(i: end, i)));
   j = j + i -1;
   M(i, :) = M(j, :);
   M(j, :) = temp;
  endfor
  pivotada = M;
end

function matrix = partialGaussJordan(M)

 tam = size(M, 1);

  for i = 1: tam
   pivo     = M(i, i);
   M(i, :)  = M(i, :) / pivo;

   for j = i + 1: tam
      factor = M(j, i);
      M(j, :) = M(j, :) - (factor * M(i, :));
   endfor

  endfor

   for i = tam : -1:1
    for j = i - 1: -1:1
       factor = M(j, i);
       M(j, :) = M(j, :) - (factor * M(i, :));
    endfor
  endfor


 matrix = M(:, tam + 1);
end
