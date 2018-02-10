function [phi]=humoment(input_image)
%if	(ndims(F) ~=2)| issparse(F) | ~isreal(F) | ~(isnumeric(F) | islogical(F))
    %error(['F must be a 2-D,real,nonsparse,numeric or logical'...
           %'matrix.']);
%end
F=double(input_image);
phi=compute_phi(compute_eta(compute_m(F)));




     



        