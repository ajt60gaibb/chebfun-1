function b = iszero( f )
%ISZERO   Check if a BALLFUN is identically zero on its domain.
%   OUT = ISZERO( F ) return 1 if the BALLFUN is exactly the zero function, and
%   0 otherwise.

% Copyright 2018 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

pref = chebfunpref();
tol = 1e7*pref.techPrefs.chebfuneps;


% Test if f = 0 at machine precision tol
F = f.coeffs;
b = norm(F(:),inf) < tol;
end
