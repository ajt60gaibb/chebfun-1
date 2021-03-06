function quiver(v,varargin)
% QUIVER Plot of a BALLFUNV on the ball with uniformly
% distributed points

% QUIVER   Quiver plot of a BALLFUNV.
%   QUIVER(V) plots the vector field of the BALLFUNV V in
%   Cartesian coordinates in a ball. QUIVER automatically scales the colors
%   of the arrows the data. The arrows are plotted on a regular grid.

% Copyright 2018 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Number of points
m = 30; n = 30; p = 30;

% Create the grid
r = chebpts(m);

% Resize the indices and grid
r = r(floor(m/2)+1:end);
m = length(r);

% Create the vector in cartesian system
Vxx = [];
Vyy = [];
Vzz = [];

% Initialize the array of points
xx = [];
yy = [];
zz = [];

for i = 1:m
    % Coordinates of the points on the sphere of radius r(i)
    Nth = max(ceil(p*r(i)/2),1);
    th_i  = linspace(0,pi,Nth);
    
    for k = 1:Nth
        Dth = min(th_i(k),abs(th_i(k)-pi));
        Nlam = max(ceil(n*r(i)*Dth*2/pi),1);
        lam_i = trigpts(Nlam)*pi;
        
        % Get the values of the vector field at these points
        [VX, VY, VZ] = fevalm(v,r(i),lam_i,th_i(k));
        
        Vxx = [Vxx;VX(1,:,1).'];
        Vyy = [Vyy;VY(1,:,1).'];
        Vzz = [Vzz;VZ(1,:,1).'];
        x = r(i)*cos(lam_i)*sin(th_i(k));
        y = r(i)*sin(lam_i).*sin(th_i(k));
        z = repmat(r(i)*cos(th_i(k)),Nlam,1);
        xx = [xx;x];
        yy = [yy;y];
        zz = [zz;z];
    end
end

q = quiver3(xx,yy,zz,real(Vxx),real(Vyy),real(Vzz), 'AutoScaleFactor',4);

% Color the vectors according to their magnitude
if  nargin==1
    % Compute the magnitude of the vectors
    mags = sqrt(sum(cat(2, q.UData(:), q.VData(:), ...
                reshape(q.WData, numel(q.UData), [])).^2, 2));
            
    % Scale the colormap to data
    caxis([0,max(mags)]);
            
    % Get the current colormap
    currentColormap = colormap();
     
    % Now determine the color to make each arrow using a colormap
    % The colors scale to the axis of the colorbar
    clims = num2cell(get(gca, 'clim'));
    [~, ~, ind] = histcounts(mags, linspace(clims{:}, size(currentColormap, 1)));

    % Now map this to a colormap to get RGB
    cmap = uint8(ind2rgb(ind(:), currentColormap) * 255);
    cmap(:,:,4) = 255;
    cmap = permute(repmat(cmap, [1 3 1]), [2 1 3]);

    % We repeat each color 3 times (using 1:3 below) because each arrow has 3 vertices
    set(q.Head, ...
        'ColorBinding', 'interpolated', ...
        'ColorData', reshape(cmap(1:3,:,:), [], 4).');   %'

    % We repeat each color 2 times (using 1:2 below) because each tail has 2 vertices
    set(q.Tail, ...
        'ColorBinding', 'interpolated', ...
        'ColorData', reshape(cmap(1:2,:,:), [], 4).');
end
hold on;

% Add label
xlabel('X')
ylabel('Y')
zlabel('Z')

% % Axis
axis([-1 1 -1 1 -1 1]);
daspect([1 1 1]);
hold off;
end