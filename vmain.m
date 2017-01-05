clear all;
close all;
tic
ab = 5;
wavfilename = 'D:\Voice Final\Samples\untitled.wav';
fp = fopen(wavfilename, 'r');
if (fp<0)
	fprintf('The file %s has not been found!\n', wavfilename);
	return;
end
fclose(fp);

% Check if it is of wav format:
if  (strcmpi(wavfilename(end-3:end),'.wav'))
    % read the wav file name:
    [x,fs] = wavread(wavfilename);
else
    fprintf('File is not in wav format!\n');
    return;
end
speech = x;
n = length(speech); %number of data points of the signal
ts = n/fs; %time of signal in seconds
tn = ts/n; %time per data point
tx = 0:tn:ts; %time axis 
signal = speech(1:length(tx)); %crop the signal for the given time
signal1 = signal;
subplot(ab,1,1), plot(tx,signal);
nfft = 2^nextpow2(n);
% the window length in seconds
wlen = 0.05;
point_per_frame = wlen/tn;
no_of_frame = floor(length(signal)/point_per_frame);
%Energy matrix
E = v_short_energy(signal, point_per_frame, no_of_frame);
E_mean = mean(E);
subplot(ab,1,3), plot(wlen*(1:no_of_frame),E);

% Centroid matrix
C = v_spec_centr(signal, point_per_frame, no_of_frame, fs, E_mean);

subplot(ab,1,2), plot(wlen*(1:no_of_frame),C);

A = zeros(length(E),3);
for i=1:length(E);
    A(i,1) = E(i);
    A(i,2) = C(i);
end

%find mean of both sequences
E_mean = mean(E);
C_mean = mean(C);
T_E = E_mean;
T_C = C_mean;

for i=1:length(E)
    if((A(i,1)>T_E && A(i,2)>T_C) || (A(i,1)>T_E && A(i,2)<T_C && A(i,2)>T_C/2) || (A(i,1)<T_E && A(i,1)>T_E/2 && A(i,2)>T_C))
        A(i,3) = 1;
    end
end
subplot(ab,1,4), plot(wlen*(1:no_of_frame),A(:,3));

A(:,3) = remove_small_noise(A(:,3),5);
A(:,3) = remove_small_speech(A(:,3),5);
[noiseinitpos,countnoise] = countsilence(A(:,3));
speechout = spec_subs(signal,noiseinitpos,countnoise,point_per_frame);
speechout = spec_subs(speechout,noiseinitpos,countnoise,point_per_frame);
% speechout = spec_subs(speechout,noiseinitpos,countnoise,point_per_frame);
subplot(ab,1,5), plot(wlen*(1:no_of_frame),A(:,3));
% signal1 = multiplyn(speechout,A,point_per_frame,no_of_frame);
toc
signal = speechout;
player = audioplayer(signal1, fs);
play(player);

pause(22);

player = audioplayer(2*speechout, fs);
play(player);