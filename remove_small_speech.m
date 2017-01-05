function [y] = remove_small_speech(x,b)
% remove very small small noise segments and count them as speech
speechinitpos = [];
countspeech = [];
countones = 0;
y = x;
flag2 = 0;
for i = 1:length(x)
    if(x(i) == 1)
        if(flag2 == 0)
            flag2 = 1;
            countones = countones+1;
            speechinitpos(end+1) = i;
        else
            if(flag2 == 1)
                countones = countones+1;
            end
        end
    else
        if(x(i) == 0)
            if(flag2 == 1)
                countspeech(end+1) = countones;
            end
            countones = 0;
            flag2 = 0;
        end
    end
end

for i = 1:length(countspeech)
    if(countspeech(i)<b)
        k = speechinitpos(i);
        for j = k:(k+countspeech(i))
            y(j) = 0;
        end
%         y(speechinitpos(i):(speechinitpos(i)+countspeech(i))) = 1;

    end
end
end