function [C] = v_spec_centr(signal, point_per_frame, no_of_frame, fs, E_mean)
% Find Spectral centroid of signal in snips of 50ms
signal = signal / max(max(signal)); %normalize the signal
% nfft = 2^nextpow2(point_per_frame);
C = zeros(no_of_frame,1);
H = hamming(point_per_frame);
m = (fs/(2*point_per_frame)).*(1:point_per_frame);
for i = 1:no_of_frame
    cursor = (i-1)*point_per_frame+1;
    window = (signal(cursor:cursor+point_per_frame-1)); %extract window
    for j = 1:length(window)
        window(j) = window(j)*H(j);
    end
    lw = length(window);
    signal_fft = fft(window,2*lw);
%     l = length(signal_fft);
    signal_fft1 = abs(signal_fft(lw+1:2*lw));
%     l1 = length(signal_fft1);
%     m = 1:lw;
    C(i,1) = sum(m.*signal_fft1)/sum(signal_fft1);
    if sum(abs(window.^2))/point_per_frame < E_mean/3
        C(i,1) = 0.0;
    end
end
C = C/max(C);