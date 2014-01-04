n=10;
close all;

E0=8.85*(10^-12);
E=12.5;
lambda=10000;
R=10;

x=linspace(-100,100,400);
y=linspace(-100,100,400);
[x,y]=meshgrid(x,y);
% [theta,r]=cart2pol(x,y);
% t = cos(theta);

R = linspace(0,100,200);
z = 10;

r = sqrt(R.^2 + z^2);
theta = atan(z./R);
t = cos(theta);

% theta = linspace(0,pi,200);
% t = cos(theta);

% Constructing (n+1)*(n+1) zero matrix

M=zeros(n+1,n+1);

% Populating first and second rows for L0(x) and L1(x)

M(1,n+1)=1;
M(2,n)=1;

% Populating the rest of the matrix using the recurrence relation, suitably adapted
% to use in matrix form.

for j=3:n+1;
    M(j,:)=((2*(j-2)+1)/((j-2)+1))*circshift(M(j-1,:),[0,-1])-((j-2)/((j-2)+1))*M(j-2,:);
end

% plot(R,r)

p = @(n,x) polyval(M(n+1,:),x);

% term1 = @(n,x) ((1/(2*n+2))-(1/(2*n-1))).*p(2*n,0).*p(2*n,x);
% term2 = @(n,x) (1/(2*n - 1)).*((r./R).^(2*n)).*p(2*n,0).*p(2*n,x);

% u = (r./R).*term1(0,t)-term2(0,t)...
%     +(r./R).*term1(1,t)-term2(1,t)...
%     +(r./R).*term1(2,t)-term2(2,t);

% u = -(1./R).*(p(0,t)...
%                 +p(2,0).*((r./R).^2).*p(2,t)...
%                 +p(4,0).*((r./R).^4).*p(4,t)...
%                 +p(6,0).*((r./R).^6).*p(6,t));

u = (R.*p(0,t) + r.*p(1,t)...
    +((r.^2)./2.*R).*p(2,t)...
    -((r.^4)./8.*R.^3).*p(4,t)...
    +((r.^6)./16.*R.^5).*p(6,t));

plot(R,u);

uu = fliplr(R);

plot(R,uu)

% plot(p(0,t),t);
% hold on
% plot(p(1,t),t);
% hold on
% plot(test,t);

% r = 0:0.1:2*pi;
% z = sin(r);
 phi = 0:pi/20:2*pi;
xx = bsxfun(@times,u',cos(phi));
yy = bsxfun(@times,u',sin(phi));
zz = repmat(R',1,length(phi));
figure;
surf(xx,yy,zz)

% [X,Y,Z] = cylinder(test);
% figure;
% surf(Y,Z,X)

% figure(3)
%  surf(x,y,P0,'EdgeColor','none')
%  surf(x,y,test,'EdgeColor','none')
% % hold on
% surf(x,y,V,'EdgeColor','none')
% surf(r,theta,V,'EdgeColor','none')