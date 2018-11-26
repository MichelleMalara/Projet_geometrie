function []= Courbe_de_bezier()

resolution=21;       % nombre de points evalues sur la courbe de Bezier
a=2;b=4;	     % domaine des parametres
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
      %Bezier_curve_points = eval_bernstein(matrice,a,b,resolution) ;
      Bezier_curve_points = eval_deCasteljau(matrice,a,b,resolution); %%%%%%%%% votre fonction !!! %%%%%%%%%%%
      %plot(Bezier_curve_points(1,:),Bezier_curve_points(2,:),'r', 'linewidth',2);  % plot de la courbe
      plot(Bezier_curve_points(1,:),Bezier_curve_points(2,:),'r');  % plot des points de la courbe
   elseif K==2 % ajouter un point
      [X,Y]=ginput(1);
      while ~isempty(X)
         n=size(matrice,2);
         matrice(1,n+1)=X;
         matrice(2,n+1)=Y;  
         clf                  % affichage d'une fenetre vide
         hold on              % tous les plot seront executes sur cette meme fenetre
         axis([0 10 0 10])    % les axes sont definitivement fixes
         %axis off
	 for k=1:n+1 % affichage du polygone de controle
	   plot(matrice(1,k), matrice(2,k),'o') % affichage du point de controle k
	 end
         plot(matrice(1,:),matrice(2,:),'b') % affichage du polygone de controle
         Bezier_curve_points = eval_deCasteljau(matrice,a,b,resolution) ;
      	 plot(Bezier_curve_points(1,:),Bezier_curve_points(2,:),'r', 'linewidth',2);
         [X,Y]=ginput(1);
      end
   elseif K==3 % supprimer un point
      
      [X,Y]=ginput(1);
      while ~isempty(X)
         if size(matrice,2)==1
            break
         end
         matrice=supprimer_point(matrice,X,Y);
         n=size(matrice,2);
         clf                  % affichage d'une fenetre vide
         hold on              % tous les plot seront executes sur cette meme fenetre
         axis([0 10 0 10])    % les axes sont definitivement fixes
         %axis off
	 for k=1:n 
	   plot(matrice(1,k), matrice(2,k),'o') % affichage du point de controle k
         end
         plot(matrice(1,:),matrice(2,:),'b') % affichage du polygone de controle
         Bezier_curve_points = eval_deCasteljau(matrice,a,b,resolution) ;
      	 plot(Bezier_curve_points(1,:),Bezier_curve_points(2,:),'r', 'linewidth',2);
         [X,Y]=ginput(1);
      end
   end
end
close
