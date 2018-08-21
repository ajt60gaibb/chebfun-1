function pass = test_curl()

S = [40,41,42];

% Example 1 : (0,x,xy)
Vx = cheb.galleryballfun("zero",S);
Vy = ballfun(@(r,lam,th)r.*sin(th).*cos(lam),S);
Vz = ballfun(@(r,lam,th)r.*sin(th).*cos(lam).*r.*sin(th).*sin(lam),S);
V = ballfunv(Vx,Vy,Vz);
W = curl(V);
Exactx = ballfun(@(r,lam,th)r.*sin(th).*cos(lam),S);
Exacty = ballfun(@(r,lam,th)-r.*sin(th).*sin(lam),S);
Exactz = ballfun(@(r,lam,th)1,S);
Exact = ballfunv(Exactx,Exacty,Exactz);
pass(1) = isequal(W,Exact);

if (nargout > 0)
    pass = all(pass(:));
end
end