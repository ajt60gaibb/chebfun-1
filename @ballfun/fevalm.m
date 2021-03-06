function vals = fevalm( f, r, lam, th)
% FEVALM   Evaluate a BALLFUN in spherical coordinates.
% 
% Z = FEVALM(F, R, LAM, TH) returns a matrix of values Z of size
% length(R)-by-length(TH)-by-length(LAM). (R,LAM,TH) are the spherical 
% coordinates for the evaluation points in the ball, with -1<=R<=1, 
% -pi <= LAM <= pi the azimuthal angle and 0 <= TH <= pi the elevation 
% (polar) angle (both measured in radians). R, LAM, and TH should be 
% vectors of doubles. This is equivalent to making a ndgrid of the vectors 
% R, LAM, and TH and then using FEVAL to evaluate at that grid.
%
% See also FEVAL. 

% Copyright 2018 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

F = f.coeffs;
[m, n, p] = size( f );

% Get the size of the lists
Nr = length( r );
Nlam = length( lam );
Nth = length( th );

% Transform the lists to vectors
r = reshape(r, Nr, 1);
lam = reshape(lam, Nlam, 1);
th = reshape(th, Nth, 1);

% Fourier functions evaluated at theta
Flambda = exp( 1i*lam.*((1:n)-floor(n/2)-1) );

% Fourier functions evaluated at lambda
Ftheta = exp( 1i*th.*((1:p)-floor(p/2)-1) );

% Chebyshev functions evaluated at r
T = zeros(Nr, m);
T(:,1) = ones(Nr, 1); 
if ( m > 1 )
    T(:,2) = r;
    for i = 3:m
        T(:, i) = 2*r.*T(:, i-1)-T(:, i-2);
    end
end

G = zeros(Nr, Nlam, p);
% Evaluate f at the points r and lambda
for i = 1:p
    G(:, :, i) = T * F(:, :, i)*Flambda.';
end

% Permute G to evaluate f at theta
G = permute(G, [3, 1, 2]);

vals = zeros(Nth, Nr, Nlam);
% Evaluate f at the points theta
for i = 1:Nlam
   vals(:, :, i) = Ftheta*G(:, :, i); 
end

% Permute H to get the array of values r x lambda x theta
vals = permute(vals, [2, 3, 1]);
end