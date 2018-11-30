function []= Courbe_de_spline()

resolution=1000;       % nombre de points evalues sur la courbe de Bezier
c= 0;
K=0;                 % variable d'etat
matrice=0;           % ensemble des points de controle
n = -1;
tan_choix = false;
while K~=7 % arr�ter
   K=menu('Que voulez-vous faire ?','NEW   (bouton souris, puis <ENTER>', 'AJOUTER LES TANGENTES AUX EXTREMITES','AJOUTER UN POINT','SUPPRIMER UN POINT', 'MODIFIER C', 'TRACER LE GRAPHE DE COURBURE', 'ARRETER')
   if K==1 % NEW
      clf                  % affichage d'une fenetre vide
      hold on              % tous les plot seront ex�cut�s sur cette meme fenetre
      axis([0 10 0 10])    % les axes sont definitivement fixes
      %axis off
      matrice=0;
      tan_choix = false;
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
      if n>0
        K3=menu('Quelle valeur de c voulez vous ?', 'CHOIX', 'DEFAULT');
        if K3==1
              c = input('Donnez une valeur de c: ');
        end
      
        K2=menu('Voulez vous choisir des tangentes aux extremités ?', 'OUI', 'DEFAULT');
      
        if K2==1
            tan_choix = true;
            [X,Y]=ginput(4);
            mzero(1) = X(2) - X(1);
            mzero(2) = Y(2) - Y(1);
            mn(1) = X(4) - X(3);
            mn(2) = Y(4) - Y(3);
        else
            mzero = calc_vect(matrice, n, 1, c);
            mn = calc_vect(matrice, n, n+1, c);
        end

        quiver(matrice(1,1), matrice(2,1), mzero(1), mzero(2));
        quiver(matrice(1,n+1), matrice(2,n+1), mn(1), mn(2));
        
      else
          mzero = [0,0];
          mn = [0,0];
      end
      
      l = 1;
      if n >= 2
          
        p0 = [matrice(1,l), matrice(2,l)];
        p1 = [matrice(1,l+1), matrice(2,l+1)];
        m0 = mzero;
        m1 = calc_vect(matrice, n, l+1, c);
        bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
        plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
        l = l+1;
        
      elseif n==1
        p0 = [matrice(1,l), matrice(2,l)];
        p1 = [matrice(1,l+1), matrice(2,l+1)];
        m0 = mzero;
        m1 = mn;
        bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
        plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
        l = l+1;
          
      end
      while l <= n-1 
          p0 = [matrice(1,l), matrice(2,l)];
          p1 = [matrice(1,l+1), matrice(2,l+1)];
          m0 = calc_vect(matrice, n, l, c);
          m1 = calc_vect(matrice, n, l+1, c);
          bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
          plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
          l = l+1;
      end
      
      if l==n
        p0 = [matrice(1,l), matrice(2,l)];
        p1 = [matrice(1,l+1), matrice(2,l+1)];
        m0 = calc_vect(matrice, n, l, c);
        m1 = mn;
        bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
        plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
      end
   elseif K==2 %modifier les tangentes
       
       tan_choix = true;
       [X,Y]=ginput(4);
       mzero(1) = X(2) - X(1);
       mzero(2) = Y(2) - Y(1);
       mn(1) = X(4) - X(3);
       mn(2) = Y(4) - Y(3);
       
       clf                  % affichage d'une fenetre vide
       hold on              % tous les plot seront executes sur cette meme fenetre
       axis([0 10 0 10])    % les axes sont definitivement fixes
         %axis off
       for k=1:n+1 
          plot(matrice(1,k), matrice(2,k),'o') % affichage du point de controle k
       end
       plot(matrice(1,:),matrice(2,:),'b') % affichage du polygone de controle
         
       if n>0
          quiver(matrice(1,1), matrice(2,1), mzero(1), mzero(2));
          quiver(matrice(1,n+1), matrice(2,n+1), mn(1), mn(2));
         
          l = 1;
            
          if n>=2
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = mzero;
              m1 = calc_vect(matrice, n, l+1, c);
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
              l = l+1;
          elseif n==1
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = mzero;
              m1 = mn;
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
              l = l+1;
          end
          while l <= n-1 
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = calc_vect(matrice, n, l, c);
              m1 = calc_vect(matrice, n, l+1, c);
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
              l = l+1;
          end
     
          if l==n
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = calc_vect(matrice, n, l, c);
              m1 = mn;
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
          end
       end
       
   elseif K==3 %ajouter point à la fin
   
      [X,Y]=ginput(1);
      while ~isempty(X)
         
         n=n+1;
         matrice(1,n+1)=X;
         matrice(2,n+1)=Y;  
         clf                  % affichage d'une fenetre vide
         hold on              % tous les plot seront executes sur cette meme fenetre
         axis([0 10 0 10])    % les axes sont definitivement fixes
         %axis off
         for k=1:n+1
            plot(matrice(1,k), matrice(2,k),'o') % affichage du point de controle k
         end
         plot(matrice(1,:),matrice(2,:),'b') % affichage du polygone de controle
         
         if ~tan_choix && n>0
             mzero = calc_vect(matrice, n, 1, c);
             mn = calc_vect(matrice, n, n+1, c);
         end
         
         if n>0
            quiver(matrice(1,1), matrice(2,1), mzero(1), mzero(2));
            quiver(matrice(1,n+1), matrice(2,n+1), mn(1), mn(2));
         
            l = 1;
            
            if n>=2
                p0 = [matrice(1,l), matrice(2,l)];
                p1 = [matrice(1,l+1), matrice(2,l+1)];
                m0 = mzero;
                m1 = calc_vect(matrice, n, l+1, c);
                bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
                plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
                l = l+1;
            elseif n==1
                p0 = [matrice(1,l), matrice(2,l)];
                p1 = [matrice(1,l+1), matrice(2,l+1)];
                m0 = mzero;
                m1 = mn;
                bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
                plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
                l = l+1;
            end
            while l <= n-1 
                p0 = [matrice(1,l), matrice(2,l)];
                p1 = [matrice(1,l+1), matrice(2,l+1)];
                m0 = calc_vect(matrice, n, l, c);
                m1 = calc_vect(matrice, n, l+1, c);
                bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
                plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
                l = l+1;
            end
            
            if l==n
                p0 = [matrice(1,l), matrice(2,l)];
                p1 = [matrice(1,l+1), matrice(2,l+1)];
                m0 = calc_vect(matrice, n, l, c);
                m1 = mn;
                bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
                plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
            end
            
            [X,Y]=ginput(1);
        end
      end
   elseif K==5 %changer la valeur de c
       
       c = input('Donnez une valeur de c: '); 
       
       if ~tan_choix && n>0
           mzero = calc_vect(matrice, n, 1, c);
           mn = calc_vect(matrice, n, n+1, c);
       end
         
       clf                  % affichage d'une fenetre vide
       hold on              % tous les plot seront executes sur cette meme fenetre
       axis([0 10 0 10])    % les axes sont definitivement fixes
         %axis off
       for k=1:n+1 
          plot(matrice(1,k), matrice(2,k),'o') % affichage du point de controle k
       end
       plot(matrice(1,:),matrice(2,:),'b') % affichage du polygone de controle
         
       if n>0
           
          quiver(matrice(1,1), matrice(2,1), mzero(1), mzero(2));
          quiver(matrice(1,n+1), matrice(2,n+1), mn(1), mn(2));
         
          l = 1;
            
          if n>=2
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = mzero;
              m1 = calc_vect(matrice, n, l+1, c);
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
              l = l+1;
          elseif n==1
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = mzero;
              m1 = mn;
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
              l = l+1;
          end
          while l <= n-1 
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = calc_vect(matrice, n, l, c);
              m1 = calc_vect(matrice, n, l+1, c);
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
              l = l+1;
          end
     
          if l==n
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = calc_vect(matrice, n, l, c);
              m1 = mn;
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
          end
       end      
         
   elseif K==4 % supprimer un point
      
      [X,Y]=ginput(1);
      while ~isempty(X)
         if size(matrice,2)==1
            break
         end
 
         matrice=supprimer_point(matrice,X,Y);
         n= size(matrice,2) - 1;
         
         if ~tan_choix && n>0
             mzero = calc_vect(matrice, n, 1, c);
             mn = calc_vect(matrice, n, n+1, c);
         end
         
        
         clf                  % affichage d'une fenetre vide
         hold on              % tous les plot seront executes sur cette meme fenetre
         axis([0 10 0 10])    % les axes sont definitivement fixes
         %axis off
         for k=1:n+1 
            plot(matrice(1,k), matrice(2,k),'o') % affichage du point de controle k
         end
         plot(matrice(1,:),matrice(2,:),'b') % affichage du polygone de controle
         
         if n>0
            quiver(matrice(1,1), matrice(2,1), mzero(1), mzero(2));
            quiver(matrice(1,n+1), matrice(2,n+1), mn(1), mn(2));
         
            l = 1;
            
            if n>=2
                p0 = [matrice(1,l), matrice(2,l)];
                p1 = [matrice(1,l+1), matrice(2,l+1)];
                m0 = mzero;
                m1 = calc_vect(matrice, n, l+1, c);
                bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
                plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
                l = l+1;
            elseif n==1
                p0 = [matrice(1,l), matrice(2,l)];
                p1 = [matrice(1,l+1), matrice(2,l+1)];
                m0 = mzero;
                m1 = mn;
                bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
                plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
                l = l+1;
            end
            while l <= n-1 
                p0 = [matrice(1,l), matrice(2,l)];
                p1 = [matrice(1,l+1), matrice(2,l+1)];
                m0 = calc_vect(matrice, n, l, c);
                m1 = calc_vect(matrice, n, l+1, c);
                bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
                plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
                l = l+1;
            end
            
            if l==n
                p0 = [matrice(1,l), matrice(2,l)];
                p1 = [matrice(1,l+1), matrice(2,l+1)];
                m0 = calc_vect(matrice, n, l, c);
                m1 = mn;
                bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
                plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
            end
            
            [X,Y]=ginput(1);
        end
      end
   elseif K==5 %changer la valeur de c
       
       c = input('Donnez une valeur de c: '); 
       
       if ~tan_choix && n>0
           mzero = calc_vect(matrice, n, 1, c);
           mn = calc_vect(matrice, n, n+1, c);
       end
         
       clf                  % affichage d'une fenetre vide
       hold on              % tous les plot seront executes sur cette meme fenetre
       axis([0 10 0 10])    % les axes sont definitivement fixes
         %axis off
       for k=1:n+1 
          plot(matrice(1,k), matrice(2,k),'o') % affichage du point de controle k
       end
       plot(matrice(1,:),matrice(2,:),'b') % affichage du polygone de controle
         
       if n>0
          quiver(matrice(1,1), matrice(2,1), mzero(1), mzero(2));
          quiver(matrice(1,n+1), matrice(2,n+1), mn(1), mn(2));
         
          l = 1;
            
          if n>=2
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = mzero;
              m1 = calc_vect(matrice, n, l+1, c);
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
              l = l+1;
          elseif n==1
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = mzero;
              m1 = mn;
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
              l = l+1;
          end
          while l <= n-1 
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = calc_vect(matrice, n, l, c);
              m1 = calc_vect(matrice, n, l+1, c);
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
              l = l+1;
          end
     
          if l==n
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = calc_vect(matrice, n, l, c);
              m1 = mn;
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
          end
       end 
       
   elseif K==6
       
       alpha = input('choisissez une valeur de alpha');
       
       clf                  % affichage d'une fenetre vide
       hold on              % tous les plot seront executes sur cette meme fenetre
       axis([0 10 0 10])    % les axes sont definitivement fixes
         %axis off
       for k=1:n+1 
          plot(matrice(1,k), matrice(2,k),'o') % affichage du point de controle k
       end
         
       if n>0
           
          l = 1;
            
          if n>=2
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = mzero;
              m1 = calc_vect(matrice, n, l+1, c);
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
              l = l+1;
              
              xprim = (bezier_curve_points(1, 2) - bezier_curve_points(1,1))*(resolution - 1);
              yprim = (bezier_curve_points(2, 2) - bezier_curve_points(2,1))*(resolution - 1);
              xsec = (bezier_curve_points(1, 3) - 2*bezier_curve_points(1,2) + bezier_curve_points(1,1))*(resolution - 1)^2;
              ysec = (bezier_curve_points(2, 3) - 2*bezier_curve_points(2,2) + bezier_curve_points(2,1))*(resolution - 1)^2;
              focale(1,1) = bezier_curve_points(1,1) + alpha * (xsec * yprim - xprim * ysec)*yprim/((xprim^2 + yprim^2)^2);  
              focale(2,1) = bezier_curve_points(2,1) + alpha * (xprim * ysec - xsec * yprim)*xprim/((xprim^2 + yprim^2)^2);
              for elt=2:(resolution - 1)
                  xprim = (bezier_curve_points(1, elt+1) - bezier_curve_points(1,elt-1))*(resolution - 1)/2;
                  yprim = (bezier_curve_points(2, elt+1) - bezier_curve_points(2,elt-1))*(resolution - 1)/2;
                  xsec =  (bezier_curve_points(1, elt+1) - 2*bezier_curve_points(1,elt) + bezier_curve_points(1,elt-1))*(resolution - 1)^2;
                  ysec = (bezier_curve_points(2, elt+1) - 2*bezier_curve_points(2,elt) + bezier_curve_points(2,elt-1))*(resolution - 1)^2;
                  focale(1,elt) = bezier_curve_points(1,elt) + alpha * (xsec * yprim - xprim * ysec)*yprim/((xprim^2 + yprim^2)^2);  
                  focale(2,elt) = bezier_curve_points(2,elt) + alpha * (xprim * ysec - xsec * yprim)*xprim/((xprim^2 + yprim^2)^2);
              end
              xprim = -(resolution - 1)*bezier_curve_points(1, resolution -1)/2;
              yprim = -(resolution - 1)*bezier_curve_points(2, resolution - 1)/2;
              xsec = -2*(resolution - 1)^2*bezier_curve_points(1, resolution) + (resolution - 1)^2*bezier_curve_points(1, resolution - 1);
              ysec = -2*(resolution - 1)^2*bezier_curve_points(2, resolution) + (resolution - 1)^2*bezier_curve_points(2, resolution - 1);
          elseif n==1
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = mzero;
              m1 = mn;
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
              l = l+1;
              
              xprim = (bezier_curve_points(1, 2) - bezier_curve_points(1,1))*(resolution - 1);
              yprim = (bezier_curve_points(2, 2) - bezier_curve_points(2,1))*(resolution - 1);
              xsec = (bezier_curve_points(1, 3) - 2*bezier_curve_points(1,2) + bezier_curve_points(1,1))*(resolution - 1)^2;
              ysec = (bezier_curve_points(2, 3) - 2*bezier_curve_points(2,2) + bezier_curve_points(2,1))*(resolution - 1)^2;
              focale(1,1) = bezier_curve_points(1,1) + alpha * (xsec * yprim - xprim * ysec)*yprim/((xprim^2 + yprim^2)^2);  
              focale(2,1) = bezier_curve_points(2,1) + alpha * (xprim * ysec - xsec * yprim)*xprim/((xprim^2 + yprim^2)^2);
              for elt=2:(resolution - 1)
                  xprim = (bezier_curve_points(1, elt+1) - bezier_curve_points(1,elt-1))*(resolution - 1)/2;
                  yprim = (bezier_curve_points(2, elt+1) - bezier_curve_points(2,elt-1))*(resolution - 1)/2;
                  xsec = (bezier_curve_points(1, elt+1) - 2*bezier_curve_points(1,elt) + bezier_curve_points(1,elt-1))*(resolution - 1)^2;
                  ysec = (bezier_curve_points(2, elt+1) - 2*bezier_curve_points(2,elt) + bezier_curve_points(2,elt-1))*(resolution - 1)^2;
                  focale(1,elt) = bezier_curve_points(1,elt) + alpha * (xsec * yprim - xprim * ysec)*yprim/((xprim^2 + yprim^2)^2);  
                  focale(2,elt) = bezier_curve_points(2,elt) + alpha * (xprim * ysec - xsec * yprim)*xprim/((xprim^2 + yprim^2)^2);
              end
              xprim = (resolution - 1)*(bezier_curve_points(1, 21)- bezier_curve_points(1, 20));
              yprim = (resolution - 1)*(bezier_curve_points(2, 21) - bezier_curve_points(2, 20));
            
          end
          while l <= n-1 
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = calc_vect(matrice, n, l, c);
              m1 = calc_vect(matrice, n, l+1, c);
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);                       
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
              
              xprim = xprim + bezier_curve_points(1,2)*(resolution -1)/2;
              yprim = yprim + bezier_curve_points(2,2)*(resolution - 1)/2;
              xsec = xsec + bezier_curve_points(1,2)*(resolution - 1)^2;
              ysec = ysec + bezier_curve_points(2,2)*(resolution - 1)^2;
              focale(1,(resolution- 1)*(l-1) + 1) = bezier_curve_points(1,1) + alpha * (xsec * yprim - xprim * ysec)*yprim/((xprim^2 + yprim^2)^2);  
              focale(2, (resolution - 1)*(l-1) + 1) = bezier_curve_points(2,1) + alpha * (xprim * ysec - xsec * yprim)*xprim/((xprim^2 + yprim^2)^2);
              
              for elt=2:(resolution - 1)
                  xprim = (bezier_curve_points(1, elt+1) - bezier_curve_points(1,elt-1))*(resolution - 1)/2;
                  yprim = (bezier_curve_points(2, elt+1) - bezier_curve_points(2,elt-1))*(resolution - 1)/2;
                  xsec = (bezier_curve_points(1, elt+1) - 2*bezier_curve_points(1,elt) + bezier_curve_points(1,elt-1))*(resolution - 1)^2;
                  ysec = (bezier_curve_points(2, elt+1) - 2*bezier_curve_points(2,elt) + bezier_curve_points(2,elt-1))*(resolution - 1)^2;
                  focale(1,(resolution - 1)*(l-1) + elt) = bezier_curve_points(1,elt) + alpha * (xsec * yprim - xprim * ysec)*yprim/((xprim^2 + yprim^2)^2);  
                  focale(2,(resolution - 1)*(l-1) + elt) = bezier_curve_points(2,elt) + alpha * (xprim * ysec - xsec * yprim)*xprim/((xprim^2 + yprim^2)^2);
              end
              xprim = -(resolution - 1)*bezier_curve_points(1, resolution - 1)/2;
              yprim = -(resolution - 1)*bezier_curve_points(2, resolution - 1)/2;
              xsec = (-2*bezier_curve_points(1, resolution) + bezier_curve_points(1, resolution - 1))*(resolution - 1)^2;
              ysec = (-2*bezier_curve_points(2, resolution) + bezier_curve_points(2, resolution - 1))*(resolution - 1)^2;
            
              l = l+1;
          end
     
          if n>=2
              
              p0 = [matrice(1,l), matrice(2,l)];
              p1 = [matrice(1,l+1), matrice(2,l+1)];
              m0 = calc_vect(matrice, n, l, c);
              m1 = mn;
              bezier_curve_points = eval_deCasteljau_2point(p0, p1, m0, m1, resolution);
              plot(bezier_curve_points(1,:),bezier_curve_points(2,:),'r', 'linewidth', 1);
             
              xprim = xprim + bezier_curve_points(1,2)*(resolution - 1)/2;
              yprim = yprim + bezier_curve_points(2,2)*(resolution - 1)/2;
              xsec = xsec + bezier_curve_points(1,2)*(resolution - 1)^2;
              ysec = ysec + bezier_curve_points(2,2)*(resolution - 1)^2;
              focale(1,(resolution - 1)*(l-1) + 1) = bezier_curve_points(1,1) + alpha * (xsec * yprim - xprim * ysec)*yprim/((xprim^2 + yprim^2)^2);  
              focale(2, (resolution - 1)*(l-1) + 1) = bezier_curve_points(2,1) + alpha * (xprim * ysec - xsec * yprim)*xprim/((xprim^2 + yprim^2)^2);
              
              for elt=2:(resolution - 1)
                  xprim = (bezier_curve_points(1, elt+1) - bezier_curve_points(1,elt-1))*25;
                  yprim = (bezier_curve_points(2, elt+1) - bezier_curve_points(2,elt-1))*25;
                  xsec = (bezier_curve_points(1, elt+1) - 2*bezier_curve_points(1,elt) + bezier_curve_points(1,elt-1))*2500;
                  ysec = (bezier_curve_points(2, elt+1) - 2*bezier_curve_points(2,elt) + bezier_curve_points(2,elt-1))*2500;
                  focale(1,(resolution - 1)*(l-1) + elt) = bezier_curve_points(1,elt) + alpha * (xsec * yprim - xprim * ysec)*yprim/((xprim^2 + yprim^2)^2);  
                  focale(2,(resolution - 1)*(l-1) + elt) = bezier_curve_points(2,elt) + alpha * (xprim * ysec - xsec * yprim)*xprim/((xprim^2 + yprim^2)^2);
              end
              
              xprim = (resolution - 1)*(bezier_curve_points(1, resolution)- bezier_curve_points(1, resolution - 1));
              yprim = (resolution - 1)*(bezier_curve_points(2, resolution) - bezier_curve_points(2, resolution - 1));
          end
          
          if n>=1
              focale(1,(resolution - 1)*n + 1) = bezier_curve_points(1,resolution) + alpha * (xsec * yprim - xprim * ysec)*yprim/((xprim^2 + yprim^2)^2);  
              focale(2,(resolution - 1)*n + 1) = bezier_curve_points(2,resolution) + alpha * (xprim * ysec - xsec * yprim)*xprim/((xprim^2 + yprim^2)^2);
              plot(focale(1,:), focale(2,:), 'g', 'linewidth', 1);
          end
       end   
   end
end
close