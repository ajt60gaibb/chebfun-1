function g = mrdivide(f,c)
%/   Right matrix divide for BALLFUN objects.
%   X = B/A or X = mrdivide(B, A) is equivalent to X = B./A.
%
% See also MLDIVIDE.

% Copyright 2018 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

g = f*(1/c);
end
