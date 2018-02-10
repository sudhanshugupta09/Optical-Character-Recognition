function d = edist(x,y)
% finds the euclidean distance d between two vectors
% d = edist(x,y)
d = sum((x-y).^2).^0.5;