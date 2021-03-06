function val = get( f, propName )
%GET       GET method for BALLFUN class.
%   P = GET(F, PROP) returns the property P specified in the string PROP from
%   the BALLFUN object F. Valid entries for the string PROP are:
%    'coeffs'

% Copyright 2018 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Get the properties.
switch ( propName )
    case 'coeffs'
        val = f.coeffs;
otherwise
        error('CHEBFUN:BALLFUN:get:propName', ...
            [propName,' is not a valid BALLFUN property.'])
end