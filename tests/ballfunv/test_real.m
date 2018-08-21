function pass = test_real( ) 
S = [20,21,22];

% Example 1
f = ballfun(@(r,lam,th)exp(1i*lam),S);
V = real(ballfunv(f,f,f));
g = ballfun(@(r,lam,th)cos(lam),S);
exact = ballfunv(g,g,g);
pass(1) = isequal(V,exact);

% Example 2
f = ballfun(@(r,lam,th)exp(1i*th.*lam),S);
V = real(ballfunv(f,f,f));
g = ballfun(@(r,lam,th)cos(lam.*th),S);
exact = ballfunv(g,g,g);
pass(2) = isequal(V,exact);

% Example 3
f1 = ballfun(@(r,lam,th)exp(1i*lam),S);
f2 = ballfun(@(r,lam,th)exp(1i*th),S);
f3 = ballfun(@(r,lam,th)exp(1i*th.*lam),S);
V = real(ballfunv(f1,f2,f3));
g1 = ballfun(@(r,lam,th)cos(lam),S);
g2 = ballfun(@(r,lam,th)cos(th),S);
g3 = ballfun(@(r,lam,th)cos(lam.*th),S);
exact = ballfunv(g1,g2,g3);
pass(3) = isequal(V,exact);

if (nargout > 0)
    pass = all(pass(:));
end
end