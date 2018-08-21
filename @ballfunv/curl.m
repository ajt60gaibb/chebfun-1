function v = curl(w)
%CURL Curl of a BALLFUNV in cartesian coordinates.
%   CURL(w) is the curl of the BALLFUNV w.
%
% See also DIV. 

% Copyright 2018 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

[Wx,Wy,Wz] = w.comp{:};
Vx = diff(Wz,2,"cart") - diff(Wy,3,"cart");
Vy = diff(Wx,3,"cart") - diff(Wz,1,"cart");
Vz = diff(Wy,1,"cart") - diff(Wx,2,"cart");
v = ballfunv(Vx,Vy,Vz);
end