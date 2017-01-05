function [y] = subs(x,n1)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% nfft = 2^nextpow2(length(x));
n = interp(n1,length(x)/length(n1));
yspeech = fft(x);
yspeech_angle = angle(yspeech);
% nfft = 2^nextpow2(length(n));
ynoise = fft(n);
% a = length(yspeech)/length(ynoise);
% ynoise = interp(ynoise,a);
yspeech_diff = abs(yspeech) - abs(2*ynoise);
for j = 1:length(yspeech_diff)
    if(yspeech_diff(j)<0)
        yspeech_diff(j) = 0;
    end
end
[m,n] = size(yspeech);
yspeech2 = zeros(m,n);
for j = 1:length(yspeech)
    yspeech2(j) = yspeech_diff(j)*exp(1i*yspeech_angle(j));
end
y = ifft(yspeech2);
end