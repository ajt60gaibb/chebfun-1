function varargout = PT2ballfunv(P,T)
% Take 2 scalar fields P and T  in Cheb-Fourier-Fourier basis and return the vector field
% v = curl(curl(rP)) + curl(rT)
%
% Also see PTDECOMPOSITION

% Copyright 2018 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Poloidal vector field
Pv = curl(rcurl(P));

% Toroidal vector field
Tv = rcurl(T);

if nargout <= 1
    varargout = {Pv + Tv};
elseif nargout == 2
    varargout = {Pv, Tv};
else
    error('BALLFUNV:PT2ballfunv:unknown', ...
          'Undefined function ''PT2ballfunv'' for %d output arguments', nargout);   
end
end

function v = rcurl(P)
% Compute v = curl(rw)

% Copyright 2018 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

[m,n,p] = size(P);

% If m and p are odd, make them even
n_tilde = n;
p_tilde = p + mod(p,2);

% The variable coefficients in the definitions of the derivatives means
% that the length of the columns and rows will increase by one wave number
% after taking the derivatives with respect to x, y and z. 
n_tilde = n_tilde + 2;
p_tilde = p_tilde + 2;

% Get the tensor of coefficients
P = P.coeffs;

% Expand P
Pexp = zeros(m,n_tilde,p_tilde);
Pexp(1:m,2:n_tilde-1,2+mod(p,2):p_tilde-1) = P;

% Useful spectral matrices
MsinL = trigspec.multmat(n_tilde, [0.5i;0;-0.5i] ); 
McosL = trigspec.multmat(n_tilde, [0.5;0;0.5] );
MsinT = trigspec.multmat(p_tilde, [0.5i;0;-0.5i] ); 
McosT = trigspec.multmat(p_tilde, [0.5;0;0.5] );

% Derivative in the lambda direction : dP/dlam
Pl = Pexp.*repmat(1i*((-floor(n_tilde/2):ceil(n_tilde/2)-1)), m, 1, p_tilde); 

% Derivative in the theta direction : dP/dth
Pt = Pexp.*repmat(reshape(1i.*(-floor(p_tilde/2):ceil(p_tilde/2)-1),[1 1 p_tilde]), m, n_tilde, 1);

% Permute Pl and Pt
Pl = permute(Pl,[2,3,1]);
Pt = permute(Pt,[2,3,1]);

% Create Vx, Vy, Vz
Vx = zeros(n_tilde,p_tilde,m);
Vy = zeros(n_tilde,p_tilde,m);
Vz = -Pl;

% Loop over m
for k = 1:m
  Vx(:,:,k) = McosL*Pl(:,:,k)*McosT.'/MsinT.' + MsinL*Pt(:,:,k);
  Vy(:,:,k) = MsinL*Pl(:,:,k)*McosT.'/MsinT.' - McosL*Pt(:,:,k);
end

% Permute back
Vx = permute(Vx,[3,1,2]);
Vy = permute(Vy,[3,1,2]);
Vz = permute(Vz,[3,1,2]);

% Simplify
Vx = simplify(ballfun(Vx,'coeffs'));
Vy = simplify(ballfun(Vy,'coeffs'));
Vz = simplify(ballfun(Vz,'coeffs'));

% Return v = curl(rP)
v = ballfunv(Vx,Vy,Vz);
end