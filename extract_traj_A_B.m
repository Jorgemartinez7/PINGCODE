% extract traj A B

N = 249;

v(:,1) = (1:1:N);
v(:,2) = X1;
v(:,3) = Y1;
v(:,4) = X2;
v(:,5) = Y2;

save('traj_A_B.txt','v','-ascii');
