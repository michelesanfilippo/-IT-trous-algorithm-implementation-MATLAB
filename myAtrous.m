function [W,Residuo] = myAtrous(img,n)

    img = rgb2gray(img);
    img = single(img);
    [h,w,~] = size(img);
    lx = [1 2 1] / 4;
    ly = lx'; % dobbiamo avere 1/16 del kernel che divido in 1/4lx e 1/4 ly
    
    W = zeros(h,w,n); % multidim. per inserire i vari piani W_i
    k1=find(lx); % utilizzerà k1 e k2 per trovare gli indici degli elementi non nulli
    k2=find(ly); % cosi da velocizzare le op. dei prodotti
    
    for k=1:n % tanti cicli quanti ne vuole l'utente
        
        copia = img; % tengo una copia dell'img per avere I_i-1 e I_i
        
        for i=1:h %scorriamo l'immagine 
            for j=1:w-k1(end) %operando prima su riga
                img(i,j) = sum(copia(i,j+k1-1) .* lx(1:2^(k-1):end)); %somma di prodotti nelle posizioni potenze di 2
            end
        end
        
        for i=1:h-k1(end) % operando su colonna (convoluzione a variabili separabili)
            for j=1:w
                img(i,j) = sum(img(i+k2-1,j) .* ly(1:2^(k-1):end));
            end
        end
        
        W(:, :, k) = (copia - img); % al k-esimo piano inserisco il filtro passa alto
        
        temp1 = zeros(1,2^(k+1)+1); %utilizzo temp1 e temp2 per ingrandire ad ogni passo il kernel
        temp2 = temp1';%utilizzo temp1 per lx e temp2 per ly
        k1=find(lx);
        k2=find(ly);%sfrutto k1 e k2 per inserire nelle posizioni potenze di 2 i valori non nulli
        temp1(1:2^k:end) = lx(k1);
        temp2(1:2^k:end) = ly(k2);
        lx = temp1; %avrà un nuovo kernel a variabili separabili piu grande
        ly = temp2;
    end
    
    Residuo = img;
    
end

                

