function g = tan(f)
%TANH   Tangent of a BALLFUN.
%   TANH(F) computes the tangent of the BALLFUN F.

% Copyright 2018 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

g = compose( f, @tan ); 
end
