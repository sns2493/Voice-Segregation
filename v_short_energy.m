function [E] = v_short_energy(signal,point_per_frame,no_of_frame)
% Computes the energy of the signal in snips of 50ms
signal = signal / max(max(signal)); %normalize the signal
E = zeros(no_of_frame,1);

for i = 1:no_of_frame
    cursor = (i-1)*point_per_frame+1;
    window = (signal(cursor:cursor+point_per_frame-1));
    E(i) = sum(abs(window.^2))/point_per_frame;
end

end