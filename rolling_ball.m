%generation of images for ball tracking
close all;
clear all;

N = 250;
dt = 0.0001;
R = 0.0213;
dA = 0.01;
dB = 0.005;
VG = 3;
Omegaz = - VG/R;

xG  = zeros(1,N);
yG = 0;
xA = zeros(1,N);
yA = zeros(1,N);
xB = zeros(1,N);
yB = zeros(1,N);
xG(1) = 0;
xA(1) = 0;
yA(1) = dA;
xB(1) = dB*sqrt(2)/2;
yB(1) = dB*sqrt(2)/2;

for ii = 1:N-1
    ii
    xG(ii) = VG*ii*dt;
    VAx = VG + (yG - yA(ii))*Omegaz;
    VAy = -(xG(ii) - xA(ii))*Omegaz;
    VBx = VG + (yG - yB(ii))*Omegaz;
    VBy = -(xG(ii) - xB(ii))*Omegaz;
    xA(ii+1) = xA(ii) + VAx*dt;
    yA(ii+1) = yA(ii) + VAy*dt;
    xB(ii+1) = xB(ii) + VBx*dt;
    yB(ii+1) = yB(ii) + VBy*dt;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(1)
        plot(xA(ii),yA(ii),'ok','MarkerSize',2,'MarkerFaceColor','k');hold on
        plot(xB(ii),yB(ii),'ok','MarkerSize',2,'MarkerFaceColor','k');
        %plot(xG(ii),0,'ok','MarkerSize',2,'MarkerFaceColor','k');
        circle(xG(ii),0,R);
        if ii<10
            filename = strcat('imag_000',num2str(ii),'.jpg');
        elseif (ii>9) && (ii<100) 
            filename = strcat('imag_00',num2str(ii),'.jpg');
        else
            filename = strcat('imag_0',num2str(ii),'.jpg');
        end
        xlim(0.01*[-3 10]);
        ylim(0.01*[-3 3]);
        axis equal;
        box off;
        axis off;
        saveas(gcf,filename);
    close(1)
end
    