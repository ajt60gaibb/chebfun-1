function varargout = subsref(f, index)
%SUBSREF   BALLFUN subsref.
%( )
%   F(X, Y, Z) or F(X, Y, Z, 'cart') returns the values of the BALLFUN 
%   object F evaluated at the points (X, Y, Z) in cartesian coordinates.
%
%   F(R, L, TH, 'polar') returns the values of the BALLFUN object F 
%   evaluated at the points (R, L, TH) in spherical scoordinates.
%
%   F(R, :, :) returns a spherefun representing the function F along a 
%   radial shell. 
% 
%   F(:, :, :) returns F.
%
%  .
%   F.PROP returns the property PROP of F as defined by GET(F,'PROP').
%
%{ } 
%   Not supported.
%
%   F.PROP returns the property of F specified in PROP.
%
% See also BALLFUN/FEVAL, BALLFUN/GET. 

% Copyright 2018 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

idx = index(1).subs;
switch index(1).type
    case '()'
        % FEVAL / COMPOSE
        if ( numel(idx) == 3 )
            % Find where to evaluate:
            x = idx{1};
            y = idx{2};
            z = idx{3};
            % If x, y, z are numeric or ':' call feval().
            if ( ( isnumeric(x) ) && ( isnumeric(y) ) && ( isnumeric(z) ) )
                out = feval(f, x, y, z);
            elseif ( isnumeric(x) && strcmpi(y, ':') && strcmpi(z, ':') )
                out = extract_spherefun( f, x ); 
            elseif ( strcmpi(x, ':') && strcmpi(y, ':') && strcmpi(z, ':') )
                out = f; 
            else
                % Don't know what to do.
                error('CHEBFUN:BALLFUN:subsref:inputs3', ...
                    'Unrecognized inputs.')
            end            
        elseif ( numel(idx) == 4 && strcmpi(idx(4),'cart') )
            
            out = feval(f, idx{1}, idx{2}, idx{3});
            
        elseif ( numel(idx) == 4 && strcmpi(idx(4),'polar') )
            
            r = idx{1};
            lam = idx{2};
            th = idx{3};
            x = @(r,lam,th)r.*sin(th).*cos(lam);
            y = @(r,lam,th)r.*sin(th).*sin(lam);
            z = @(r,lam,th)r.*cos(th);
            out = feval(f, x(r,lam,th), y(r,lam,th), z(r,lam,th));
            
        else
            error('CHEBFUN:BALLFUN:subsref:inputs', ...
                'Can only evaluate at triples (X,Y,Z) or (R,LAM,TH).')
        end
        varargout = {out};
        
    case '.'
        % Call GET() for .PROP access.
        out = get(f, idx);
        if ( numel(index) > 1 )
            % Recurse on SUBSREF():
            index(1) = [];
            out = subsref(out, index);
        end
        varargout = {out};
        
    case '{}'
        % RESTRICT
        error('CHEBFUN:BALLFUN:subsref:restrict', ...
                ['This syntax is reserved for restricting',...
                 'the domain of a ballfun. This functionality'...
                 'is not available in Ballfun.'])
        
end

end

function g = extract_spherefun(f, r)
% EXTRACT_SPHEREFUN SPHEREFUN corresponding to the value of f at radius r
%   EXTRACT_SPHEREFUN(f, r) is the SPHEREFUN function 
%   g(lambda, theta) = f(r, :, :)

% Copyright 2018 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

F = f.coeffs;
[m,n,p] = size(f);

if m == 1
    G = reshape(F(1,:,:),n,p);
else
    % Chebyshev functions evaluated at r
    T = zeros(1,m);
    T(1) = 1; T(2) = r;
    for i = 3:m
        T(i) = 2*r*T(i-1)-T(i-2);
    end

    % Build the array of coefficient of the spherefun function
    G = zeros(n,p);
    for i = 1:p
        G(:,i) = T*F(:,:,i);
    end
end
% Build the spherefun function; coeffs2spherefun takes the theta*lambda matrix
% of coefficients
g = spherefun.coeffs2spherefun(G.');
end