function [fl re]=segmentlines(im_texto)
[f c]=find(im_texto);
rim_texto=im_texto(min(f):max(f),min(c):max(c)); 
num_filas=size(im_texto,1);
for s=1:num_filas
    if sum(im_texto(s,:))==0
        nm=im_texto(1:s-1, :); % First line matrix
        rm=im_texto(s:end, :);% Remain line matrix
        [f c]=find(nm);
        fl=nm(min(f):max(f),min(c):max(c));
        [f c]=find(rm);
        re=rm(min(f):max(f),min(c):max(c)); 
        break
    else
        fl=im_texto;%Only one line.
        re=[ ];
    end
end

