function List3GaussianElimination()
 A = [ 2 0 1  ;
       5 -1 1 ;
     - 1 2 2  ;];

B = [2; 5; 0;];
  M = [A B];
  M = pivotamento(M);
  M = gaussElimination(M)

end


function pivotada = pivotamento(M)

 tam = size(M, 1);

  for i = 1: tam
   temp = M(i, :);
   [pivo, j] = max(abs(M(i: tam, i)));
   j = j + i -1;
   M(i, :) = M(j, :);
   M(j, :) = temp;
  endfor
  pivotada = M;
end


function matrix = gaussElimination(M)

  tam = size(M, 1);

  for i = 1: tam
    factor = M(i, i);
    for j = i + 1: tam
       factor = M(j, i) / M(i, i) ;
       M(j, :) = M(j, :) - factor * M(i, :);
    endfor
  endfor

  matrix = zeros(tam, 1);

  matrix(tam) = M(tam, end) / M(tam, tam);

 for i = tam -1: -1:1

    matrix(i) = (M(i, end) -  M(i, i+1:tam) * matrix(i+1:tam)) / M(i, i);

endfor

end
