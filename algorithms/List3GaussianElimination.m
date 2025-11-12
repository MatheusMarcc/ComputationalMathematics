function List3GaussianElimination()
  A = [1 6 3 -3 2;
       2 7 1  2 5;
       1 5 3 -3 3;
      0 -6 -2 3 6;
       ]

  M = pivotamento(A)

end


function pivotada = pivotamento(M)

 tam = size(M, 1);

  for i = 1: tam
   [pivo, j] = max(abs(M(i: tam, i)));
   temp = M(i, :);
   M(i, :) = M(j, :);
   M(j, :) = temp;
  endfor
  pivotada = M;
end
