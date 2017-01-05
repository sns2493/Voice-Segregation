function [x] = multiplyn(signal,A,point_per_frame,no_of_frame)
x = zeros(size(signal));
for i=1:no_of_frame
    for j = ((i-1)*point_per_frame+1):(i*point_per_frame-1)
        x(j) = signal(j)*A(i,3);
    end
end
end