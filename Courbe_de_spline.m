function []= Courbe_de_spline()

resolution=21;       % nombre de points evalues sur la courbe de Bezier
c= 0.5;
K=0;                 % variable d'etat
matrice=0;           % ensemble des points de controle

while K~=4 % arr�ter
   K=menu('Que voulez-vous faire ?','NEW   (bouton souris, puis <ENTER>', 'AJOUTER UN POINT','SUPPRIMER UN POINT','ARRETER')
   if K==1 % NEW
      clf                  % affichage d'une fenetre vide
      hold on              % tous les plot seront ex�cut�s sur cette meme fenetre
      axis([0 10 0 10])    % les axes sont definitivement fixes
      %axis off
      matrice=0;
      for i=1:1000         % on limite le nombre de points de controle � 1000
         [X,Y]=ginput(1);  % prise en compte d'un clic de souris
         if isempty(X)     % si on appuie sur <ENTER>
            break
         end
         matrice(1,i)=X;   % coordonnees x des points de controle
         matrice(2,i)=Y;   % coordonnees y des points de controle
	 plot(matrice(1,i),matrice(2,i),'o') % affichage du point de controle i
         plot(matrice(1,:),matrice(2,:),'b') % affichage du polygone de controle
      end
      n = size(matrice,2) - 1;
      l = 1;
      while l <= n 
          p0 = [matrice(1,l), matrice(2,l)];
          p1 = [matrice(1,l+1), matrice(2,l+1)];
          m0 = calc_vect(matrice, n, l, c);
          m1 = calc_vect(matrice, n, l+1, c);
          bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
          plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 2);
          l = l+1;
      end
   end
end
close