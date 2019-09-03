
%% Return the angle of the best view for face parts recognition...!!!

function ang = eeg_E_mejor_vista(vistas)
[a b] = size(vistas);
superior = vistas(floor(a/2):a,:);
inferior = vistas(1:floor(a/2),:);
[a,b]=size(superior);
matriz=[];
for i=a:-1:1
    if(eeg_F_hayceros(superior(i,:))==1)
        i=1;
    else
        matriz = [superior(i,:);matriz];
    end
end
[x,y]=size(inferior);
for i=1:1:x
    if(eeg_F_hayceros(superior(i,:))==1)
        i=x;
    else
        matriz = [matriz;superior(i,:)];
    end
end
%% Promediar los angulos de la primera y la ultima vista para tener la cara de frente !!!!!
[a b]=size(matriz);
ang = round(matriz(1,b)+matriz(a,b))/2; % Este es el angulo de la vista mas de frente, MEJOR VISTA. 

%% Buscar todas las vistas en las que no se detecto algo (buscando valores iguales a cero)... 
% Me quedo con una matriz en la que todas las vistas se detectaron todas las partes del rostro
