function pass = test_feval( pref ) 

% Grab some preferences
if ( nargin == 0 )
    pref = chebfunpref();
end
tol = 1e2*pref.techPrefs.chebfuneps;

zero = cheb.galleryballfun('zero');
r = 0.5; lam = pi; th = pi/2;

% Example 1:
f = ballfun(@(r,lam,th)1, 'polar');
F = ballfunv(f,zero,zero);
vals = feval(F,r,lam,th);
vals_exact = zeros(1,1,1,3);
vals_exact(:,:,:,1) = 1;
pass(1) = norm(vals(:) - vals_exact(:),inf) < tol;

% Example 2:
f = ballfun(@(r,lam,th)r.*sin(th).*cos(lam), 'polar');
F = ballfunv(zero,zero,f);
vals = feval(F,r,lam,th);
vals_exact = zeros(1,1,1,3);
vals_exact(:,:,:,3) = -0.5;
pass(2) = norm(vals(:) - vals_exact(:),inf) < tol;

if (nargout > 0)
    pass = all(pass(:));
end
end
