
%Return 1 if the vector contains at least a cero

function salida = eeg_F_hayceros(vector)
[a b] = size(vector);
salida=[];
for i=1:length(vector)
    if vector(1,i)==0
        salida = 1;
        return;
    else
        salida = 0;
    end
end
end
