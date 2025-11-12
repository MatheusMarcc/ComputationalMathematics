function list3Exercise13()
 A = [ 2 0 1 2;
       5 -1 1 5;
     - 1 2 2 0;];


 M = pivotamento(A)
 M = partialGaussJordan(M)
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


