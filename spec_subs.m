function [speechout] = spec_subs(signal,noiseinitpos,countnoise,point_per_frame)
cursegment =[];
curnoise = [];
speechout = [];
for i = 1:length(noiseinitpos)-1
    a = noiseinitpos(i)-1;
    a = a*point_per_frame;
    b = (countnoise(i)-2)*point_per_frame;
    curnoise = signal(a+1:a+point_per_frame);
%     if(i < length(noiseinitpos))
        c = (noiseinitpos(i+1)-1)*point_per_frame;
%     else
%         i
%         c = length(signal);
%     end
    cursegment = signal(a+1:c);
    speechout(a+1:c) = subs(cursegment,curnoise);
end
end