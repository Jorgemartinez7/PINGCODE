% extract Omega

clear all;
close all;
format long;

image = imread('TEST3-10000.jpg');
Dim = size(image);
DimX = Dim(2);
DimY = Dim(1);

N = 249;
dt = 0.0001;
Rm = 0.0213;
Nav = 20;

load traj_G.txt
time = dt*traj_G(:,1);
Rpix = mean(traj_G(:,4));
cal = Rm/Rpix; % calibration factor cm/pixel
xG = cal*traj_G(:,2); yG = cal*(DimY - traj_G(:,3));
xGf = movmean(xG,Nav); yGf = movmean(yG,Nav);

load traj_A_B.txt
xA = cal*(traj_A_B(:,2)); yA = cal*(DimY - traj_A_B(:,3));
xB = cal*(traj_A_B(:,4)); yB = cal*(DimY - traj_A_B(:,5));
xAf = movmean(xA,Nav); yAf = movmean(yA,Nav);
xBf = movmean(xB,Nav); yBf = movmean(yB,Nav);

figure(1)
%plot(xG,yG,'-k'); hold on;
plot(xGf,yGf,'-k');hold on;
plot(xAf,yAf,'-b');
plot(xBf,yBf,'-r');
axis equal
% xlim([0 cal*DimX]);
% ylim([0 cal*DimY]);
xlabel('x (m)')
ylabel('y (m)')


VAx = diff(xAf)/dt; VAy = diff(yAf)/dt;
VBx = diff(xBf)/dt; VBy = diff(yBf)/dt;
VGx = diff(xGf)/dt; VGy = diff(yGf)/dt;

Omega1 = (VBx - VAx)./(yA(1:N-1) - yB(1:N-1));
Omega2 = (VAy - VBy)./(xA(1:N-1) - xB(1:N-1))

figure(2);
plot(time(1:N-1),VGx,'-k','LineWidth',1);
ylim([0 1.2*max(VGx)])
xlabel('time (s)')
ylabel('x-component of the center of mass velocity, V_G_x (m/s)')

figure(3);
plot(time(1:N-1),Omega1,'--k','LineWidth',1);hold on;
plot(time(1:N-1),Omega2,':k','LineWidth',1);
xlabel('time (s)')
ylabel('z-component of the rotation vector, \Omega (1/s)')

