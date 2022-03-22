clear
clc


N = 1241;
dt = 0.0001;
Rm = 0.0213;
Nav = 20;
Ang_sum = 0;


image = imread('TEST3-10000.jpg');
Dim = size(image);
DimX = Dim(2);
DimY = Dim(1);

load traj_G.txt
time = dt*traj_G(:,1);
Rpix = mean(traj_G(:,4));
cal = Rm/Rpix; % calibration factor cm/pixel
xG = cal*traj_G(:,2); yG = cal*(DimY - traj_G(:,3));
xGf = movmean(xG,Nav); yGf = movmean(yG,Nav);figure(1)


plot(xG,yG,'-k'); hold on;
plot(xGf,yGf,'-k');hold on;
axis equal
xlim([0 cal*DimX]);
ylim([0 cal*DimY]);
xlabel('x (m)')
ylabel('y (m)')
title('Top view deviation of golf ball')


%calc for angle
for k=3:N-1
Angle_deviation= atan(yGf(k)-yGf(k-1) / xGf(k)-xGf(k-1));
Ang_sum = Ang_sum + Angle_deviation ;
end

Ang_Avg = Ang_sum / N-1;
fprintf('The Average angle of deviation produced: \n %d',Ang_Avg)

%calc for angle at impact
for k=2:22
Angle_deviation= atan(yGf(k)-yGf(k-1) / xGf(k)-xGf(k-1));
Ang_sum = Ang_sum + Angle_deviation ;
end

Ang_imp = Ang_sum / 21;
fprintf('\nThe  angle of deviation on impact produced: \n %d',Ang_imp)



