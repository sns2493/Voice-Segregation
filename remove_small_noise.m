function [y] = remove_small_noise(x,a)
% remove very small small noise segments and count them as speech
noiseinitpos = [];
countnoise = [];
countzero = 0;
y = x;
flag2 = 1;
for i = 1:length(x)
    if(x(i) == 0)
        if(flag2 == 1)
            flag2 = 0;
            countzero = countzero+1;
            noiseinitpos(end+1) = i;
        else
            if(flag2 == 0)
                countzero = countzero+1;
            end
        end
    else
        if(x(i) == 1)
            if(flag2 == 0)
                countnoise(end+1) = countzero;
            end
            countzero = 0;
            flag2 = 1;
        end
    end
end

for i = 1:length(countnoise)
    if(countnoise(i)<a)
        k = noiseinitpos(i);
        for j = k:(k+countnoise(i))
            y(j) = 1;
        end
%         y(noiseinitpos(i):(noiseinitpos(i)+countnoise(i))) = 1;

    end
end
end