n=10;
close all;

E0=8.85*(10^-12);
E=12.5;
lambda=10000;
R=10;

% x=linspace(-100,100,200);
% y=linspace(-100,100,200);
% [x,y]=meshgrid(x,y);
% [theta,r]=cart2pol(x,y);
% t = cos(theta);

theta = linspace(0,pi,200);
t = cos(theta);

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

% Creating vector containing 1000 equally spaced points between -1 and 1. 

a=linspace(-1,1,1000);

% Using polyval function to extract polynomials from rows of matrix, first
% row corresponds to phi0, second row to phi1, etc... Then using vector x
% as input.

P0=polyval(M(1,:),t);
P1=polyval(M(2,:),t);
P2=polyval(M(3,:),t);
P3=polyval(M(4,:),t);
P4=polyval(M(5,:),t);
P5=polyval(M(6,:),t);
P6=polyval(M(7,:),t);
P7=polyval(M(8,:),t);
P8=polyval(M(9,:),t);
P9=polyval(M(10,:),t);
P10=polyval(M(11,:),t);

% P0=polyval(M(1,:),a);
% P1=polyval(M(2,:),a);
% P2=polyval(M(3,:),a);
% P3=polyval(M(4,:),a);
% P4=polyval(M(5,:),a);
% P5=polyval(M(6,:),a);
% P6=polyval(M(7,:),a);
% P7=polyval(M(8,:),a);
% P8=polyval(M(9,:),a);
% P9=polyval(M(10,:),a);
% P10=polyval(M(11,:),a);

% V0=(coefficients(0))*P0*(r.^0);
% V1=(coefficients(1))*P1*(r.^1);
% V2=(coefficients(2))*P2*(r.^2);
% V3=(coefficients(3))*P3*(r.^3);
% V4=(coefficients(4))*P4*(r.^4);
% V5=(coefficients(5))*P5*(r.^5);
% V6=(coefficients(6))*P6*(r.^6);
% V7=(coefficients(7))*P7*(r.^7);
% V8=(coefficients(8))*P8*(r.^8);
% V9=(coefficients(9))*P9*(r.^9);
% V10=(coefficients(10))*P10*(r.^10);
% V=V1+V2+V3+V4+V5+V6+V7+V8+V9+V10;

% V0=1*P0*(r.^0);
% V1=-1*P1*(r);
% V2=0.5*P2*(r.^2);
% V3=0*P3*(r.^3);
% V4=(-1/8)*P4*(r.^4);
% V5=0*P5*(r.^5);
% V6=(1/16)*P6*(r.^6);
% V7=0*P7*(r.^7);
% V8=(-5/128)*P8*(r.^8);
% V9=0*P9*(r.^9);
% V10=(7/256)*P10*(r.^10);
% V=V0+V1+V2+V3+V4+V6+V8+V10;

disp(M)

% Plotting polynomials against x

% figure(1)
% plot(a,P0,'k')
% hold on
% plot(a,P1,'g')
% hold on
% plot(a,P2,'r')
% hold on
% plot(a,P3,'b')
% hold on
% plot(a,P4,'k')
% hold on
% plot(a,P5,'c')

% figure(2)
% plot(t,V0)
% hold on
% plot(t,V1)

test = P0-P1+P2-P4+P6-P8+P10;
plot(P0,t);
hold on
plot(P1,t);
hold on
plot(test,t);

r = 0:0.1:2*pi;
z = sin(r);
theta = 0:pi/20:2*pi;
xx = bsxfun(@times,t',cos(theta));
yy = bsxfun(@times,t',sin(theta));
zz = repmat(test',1,length(theta));
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