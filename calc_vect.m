
function[mk] = calc_vect(matrice,n, l, c)
if l==1
    mk = [(1-c)*(matrice(1, l+1) - matrice(1,l)), (1-c)*(matrice(2, l+1) - matrice(2,l))];
elseif l == n+1
    mk = [(1-c)*(matrice(1, l) - matrice(1,l-1)), (1-c)*(matrice(2, l) - matrice(2,l-1))];
else
    mk = [(1-c)*(matrice(1, l+1) - matrice(1,l-1))/2, (1-c)*(matrice(2, l+1)- matrice(2,l-1))/2];
end
end

