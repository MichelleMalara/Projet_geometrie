function [ matrice2 ] = supprimer_point(matrice,X,Y)

n=size(matrice,2);
min=sqrt((matrice(1,1)-X)^2+(matrice(2,1)-Y)^2);
i_mem=1;

for i=2:n
   a=sqrt((matrice(1,i)-X)^2+(matrice(2,i)-Y)^2);
   if a<min
      min=a;
      i_mem=i;
   end
end % renvoie le numéro du point le plus proche de (X,Y)

for i=1:i_mem-1
   matrice2(1,i)=matrice(1,i);
   matrice2(2,i)=matrice(2,i);
end
for i=i_mem:n-1
   matrice2(1,i)=matrice(1,i+1);
   matrice2(2,i)=matrice(2,i+1);
end
matrice2;

   
