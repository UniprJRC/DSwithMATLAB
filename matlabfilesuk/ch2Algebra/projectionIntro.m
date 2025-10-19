close all
x = [1;2;3];
v = [2;2.4;3.5];
t = x'*v/(v'*v);
hatx = t*v;

dist = norm(x-hatx);
disp(['Distance from x to line: ' num2str(dist)])

projlen = norm(hatx);
disp(['Projection length: ' num2str(projlen)])

disp('Check orthogonality v''*(x-hatx):')
disp(v'*(x-hatx))

figure
fs = 14;
quiver3(0,0,0,x(1),x(2),x(3),0,'b'); hold on
text(x(1),x(2),x(3),'x','FontSize',fs)
quiver3(0,0,0,v(1),v(2),v(3),0,'m')
text(v(1),v(2),v(3),'v','FontSize',fs)
quiver3(0,0,0,t*v(1),t*v(2),t*v(3),0,'k')

% Remark: the dx values were entered manually to prevent
% the text from overlapping the vector (not the book)
dx=[-0.1 -0.4 0];
text(t*v(1)+dx(1),t*v(2)+dx(2),t*v(3)+dx(3), ['$\hat x=tv=' num2str(t) '*v$'], ...
    'FontSize',fs,'Rotation',-5, 'Interpreter','latex');

quiver3(x(1),x(2),x(3),-x(1)+hatx(1),-x(2)+hatx(2),-x(3)+hatx(3),0,'r')
dy=0.15;
text(x(1),x(2),x(3)+dy,'$x-\hat x$','FontSize',fs,'Rotation',-57,'Interpreter','latex')
xlabel('First coordinate'); 
ylabel('Second coordinate'); 
zlabel('Third coordinate')
axis equal

%% Example of two vectors  x and v which are orthogonal 
% x = coordinates of the vector (point) to be projected onto v
x = [1; 1; 0];
% The direction of vector v is
v = [1; -1; 0];
% In this example, the vectors x and v are orthogonal (their dot product is 0);
% consequently, t = 0
t = x' * v / (v' * v);
r_0 = [0; 0; 0];
% The vector hatx is simply the point with coordinates 0 0 0
hatx = r_0 + t * v;
% dist = || x - hatx ||
dist = norm(x - hatx);
disp(['The distance is equal to: ' num2str(dist)])
% The distance is nothing but the norm of vector x (since hatx = 0)
% In other words, in this example the distance is the square root of 2,
% that is, the norm of vector x
figure
fs=14;
quiver3(0,0,0,x(1),x(2),x(3),0)
hold("on")
xstri=string(x);
testox="x=(" + xstri(1) + "," + xstri(2) + "," + xstri(3) + ")";
vstri=string(v);
testov="v=(" + vstri(1) + "," + vstri(2) + "," + vstri(3) + ")";
dx=0.01;
text(x(1)+dx,x(2)+dx,x(3)+dx,testox,"FontSize",fs);
quiver3(0,0,0,v(1),v(2),v(3),0)
text(v(1),v(2),v(3),testov,"FontSize",fs);

quiver3(0,0,0,t*v(1),t*v(2),t*v(3),0)
text(t*v(1),t*v(2),t*v(3),['tv=' num2str(t) '*v'],"FontSize",fs,'HorizontalAlignment','right');

axis equal
xlabel('First coordinate')
ylabel('Second coordinate')
zlabel('Third coordinate')
title('Projection of vector x into v')
subtitle('Note that the two initial vectors are orthogonal therefore t=0')
