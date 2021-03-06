function g = log(f)
%LOG   Natural logarithm of a BALLFUN.
%   LOG(F) returns the natural logarithm of F. If F has any roots in its domain,
%   then the representation is likely to be inaccurate.

% Copyright 2018 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Return the logarithm of the ballfun function f
g = compose( f, @log ); 

end
