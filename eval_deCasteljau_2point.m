
function [Bezier_curve_points]= eval_deCasteljau_2point(p0, p1, m0, m1, resolution)
n = 3; %4 point de controles
temps= 0 : (1/resolution) : 1;
cp = 0;
for t=temps
   % matrice point de controle
   matrice_calc(:,1) = p0;
   matrice_calc(:,2) = p0 + m0/3;
   matrice_calc(:,3) = p1 - m1/3;
   matrice_calc(:,4) = p1;
   % Calcul du point de la courbe x(t) avec l'algorithme de DeCasteljau
   nbis = n;
   while nbis>0
       for i=1:nbis
           matrice_calc(1,i)= (1-t)*matrice_calc(1,i) + t*matrice_calc(1, i+1);
           matrice_calc(2,i)= (1-t)*matrice_calc(2,i) + t*matrice_calc(2, i+1);
       end
       nbis = nbis-1;
   end
   cp = cp+1;
   Bezier_curve_points(1,cp)= matrice_calc(1,1);
   Bezier_curve_points(2,cp)= matrice_calc(2,1);
end                 