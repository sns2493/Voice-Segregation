function [Maxima, count_maxima] = find_maxima(f,step)
% find values and position of maxima in the sequences
countMaxima = 0;
for (i=1:length(f)-step-1) % for each element of the sequence:
    if (i>step)
        if (( mean(f(i-step:i-1))< f(i)) && ( mean(f(i+1:i+step))< f(i)))  
            % IF the current element is larger than its neighbors (2*step window)
            % --> keep maximum:
            countMaxima = countMaxima + 1;
            Maxima(1,countMaxima) = i;
            Maxima(2,countMaxima) = f(i);
        end
    else
        if (( mean(f(1:i))<= f(i)) && ( mean(f(i+1:i+step))< f(i)))  
            % IF the current element is larger than its neighbors (2*step window)
            % --> keep maximum:
            countMaxima = countMaxima + 1;
            Maxima(1,countMaxima) = i;
            Maxima(2,countMaxima) = f(i);
        end
    end
end
count_maxima = countMaxima;
%
MaximaNew = [];
countNewMaxima = 0;
i = 0;
while (i<countMaxima)
    % get current maximum:
    i = i + 1;
    curMaxima = Maxima(1,i);
    curMavVal = Maxima(2,i);
    
    tempMax = Maxima(1,i);
    tempVals = Maxima(2,i);
    
    % search for "neighbourh maxima":
    while ((i<countMaxima) && ( Maxima(1,i+1) - tempMax(end) < step / 2))
        i = i + 1;
        tempMax(end+1) = Maxima(1,i);
        tempVals(end+1) = Maxima(2,i);
    end
    
   
    % find the maximum value and index from the tempVals array:
    
    [MM, MI] = max(tempVals);
        
    if (MM>0.02*mean(f)) % if the current maximum is "large" enough
        countNewMaxima = countNewMaxima + 1;   % add maxima
        % keep the maximum of all maxima in the region
        MaximaNew(1,countNewMaxima) = tempMax(MI); 
        MaximaNew(2,countNewMaxima) = f(MaximaNew(1,countNewMaxima));
    end        
    tempMax = [];
    tempVals = [];
end
Maxima = MaximaNew;
count_maxima = countNewMaxima;
end