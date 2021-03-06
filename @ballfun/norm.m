function nm = norm(f, varargin)
%NORM  Frobenius norm of a BALLFUN.
% 
% For BALLFUN objects:
%    NORM(F) = sqrt(integral of abs(F)^2).

% Copyright 2018 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Do something faster for the test

F = f.coeffs;
Ref = ballfun.vals2coeffs(real( ballfun.coeffs2vals( F ) ));
Imf = ballfun.vals2coeffs(imag( ballfun.coeffs2vals( F ) ));
g = f.*ballfun(Ref-Imf,'coeffs');

%g = f.*conj(f);

nm = sqrt(abs(sum3(g)));
end
