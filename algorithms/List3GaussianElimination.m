function List3GaussianElimination()
  A = [3  -0.1 -0.2;
       0.1  7  -0.3;
       0.3 -0.2 10
       ];

  B = [7.85; -19.3; 71.4];
  M = [A B]
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
    for j = i+ 1: tam
       factor = M(j, i) / M(i, i) ;
       M(j, :) = M(j, :) - factor * M(i, :);
    endfor
  endfor

 for i = tam:-1:1
    M(i, tam+1) = M(i, tam+1) / M(i, i);
    M(i, i) = 1;
    for j = i-1:-1:1
        M(j, tam+1) = M(j, tam+1) - M(j, i) * M(i, tam+1);
        M(j, i) = 0;
    endfor
endfor

 matrix = M;

end
