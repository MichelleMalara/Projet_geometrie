function [ i_mem ] = indice_suppression(matrice, X, Y)

n=size(matrice,2);
min=sqrt((matrice(1,1)-X)^2+(matrice(2,1)-Y)^2);
i_mem=1;

for i=2:n
   a=sqrt((matrice(1,i)-X)^2+(matrice(2,i)-Y)^2);
   if a<min
      min=a;
      i_mem=i;
   end
end % renvoie le num�ro du point le plus proche de (X,Y)