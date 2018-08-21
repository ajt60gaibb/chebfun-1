function pass = test_plus( )
S = [23,24,21];

% Example 1
f1 = ballfun(@(r,lam,th)r.*cos(th),S);
f2 = ballfun(@(r,lam,th)r.*cos(th).*sin(lam),S);
f3 = ballfun(@(r,lam,th)r.*cos(th).^2,S);
f = ballfunv(f1,f2,f3);
g = f+f;
e1 = ballfun(@(r,lam,th)2*r.*cos(th),S);
e2 = ballfun(@(r,lam,th)2*r.*cos(th).*sin(lam),S);
e3 = ballfun(@(r,lam,th)2*r.*cos(th).^2,S);
exact = ballfunv(e1,e2,e3);
pass(1) = isequal(g,exact);

% Example 2
f1 = ballfun(@(r,lam,th)r.*cos(th),S);
f2 = ballfun(@(r,lam,th)r.*cos(th).*sin(lam),S);
f3 = ballfun(@(r,lam,th)r.*cos(th).^2,S);
f = ballfunv(f1,f2,f3);
g = f+1;
e1 = ballfun(@(r,lam,th)r.*cos(th)+1,S);
e2 = ballfun(@(r,lam,th)r.*cos(th).*sin(lam)+1,S);
e3 = ballfun(@(r,lam,th)r.*cos(th).^2+1,S);
exact = ballfunv(e1,e2,e3);
pass(2) = isequal(g,exact);

% Example 3
f1 = ballfun(@(r,lam,th)r.*cos(th),S);
f2 = ballfun(@(r,lam,th)r.*cos(th).*sin(lam),S);
f3 = ballfun(@(r,lam,th)r.*cos(th).^2,S);
f = ballfunv(f1,f2,f3);
g = 3+f;
e1 = ballfun(@(r,lam,th)r.*cos(th)+3,S);
e2 = ballfun(@(r,lam,th)r.*cos(th).*sin(lam)+3,S);
e3 = ballfun(@(r,lam,th)r.*cos(th).^2+3,S);
exact = ballfunv(e1,e2,e3);
pass(3) = isequal(g,exact);

if (nargout > 0)
    pass = all(pass(:));
end
end