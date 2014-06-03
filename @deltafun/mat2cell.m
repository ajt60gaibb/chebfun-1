function f = mat2cell(f, varargin)
%MAT2CELL   Wrap a DELTAFUN in a cell.
%   DELTAFUN objects are not array-valued, so G = MAT2CELL(F) simply wraps F is a
%   cell array and is equivalent to G = {F}.

% Copyright 2014 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

if ( any(cellfun(@(v) v ~= 0, varagin)) )
    error('CHEBFUN:mat2cell:inputs', ...
        'DELTAFUN objects are not array-valued, so M and n must equal 1.');
end

f = {f};

end
