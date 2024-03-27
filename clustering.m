%% Clear workspace
clc; clear; close all;

%% Data
sig_y = [8.9 8.1 7.3 8.3]; % yield stress
del_y = [1.4 1.6 1.8 1.9]; % yield strain
X = [del_y' sig_y']; % materials
% plot data
figure(1)
plot(X(:,1),X(:,2),'*')
axis([0.5 2.5 5 10])
title('Data of Unidentified Materials')
xlabel('Yield Strain')
ylabel('Yield Stress')

%% Fuzzy C Means
K = 2; % number of clusters
[center,U,objFcn] = fcm(X,K); % find clusters
% plot objective function convergence
figure(2)
plot(objFcn)
% We plot the separate clusters classified by the fcm routine.
figure(3)
maxU = max(U);
index1 = find(U(1, :) == maxU);
index2 = find(U(2, :) == maxU);
fcmdata=X;
line(fcmdata(index1, 1), fcmdata(index1, 2), 'linestyle',...
'none','marker', 'o','color','g');
line(fcmdata(index2,1),fcmdata(index2,2),'linestyle',...
'none','marker', 'x','color','r');
hold on
plot(center(1,1),center(1,2),'ko','markersize',15,'LineWidth',2)
plot(center(2,1),center(2,2),'kx','markersize',15,'LineWidth',2)
axis([0.5 2.5 5 10])
legend('Cluster 1','Cluster 2','Location','Best')
title('Data of Unidentified Materials')
xlabel('Yield Strain')
ylabel('Yield Stress')

%% K Means
K=2; % Number of clusters
[idx,ctrs, SUMD, D] = kmeans(X,K); 

figure(4)
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',14)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',14)
hold on
plot(ctrs(:,1),ctrs(:,2),'kx',...
     'MarkerSize',12,'LineWidth',2)
plot(ctrs(:,1),ctrs(:,2),'ko',...
     'MarkerSize',12,'LineWidth',2)
axis([0.5 2.5 5 10])
legend('Cluster 1','Cluster 2','Centroids','Location','Best')
title('Data of Unidentified Materials')
xlabel('Yield Strain')
ylabel('Yield Stress')

%% run 50 times
sims = 50;
% build arrays for simulation data
fcm_C1 = zeros(sims, 2);  % cluster 1 by c means
fcm_C2 = zeros(sims, 2); % cluster 2 by c means
kmns_C1 = zeros(sims, 2); % cluster 1 by k means
kmns_C2 = zeros(sims, 2); % cluster 2 by k means
for i = 1:sims
    [ctrs1,U1] = fcm(X,K);
    [idx1,ctrs2] = kmeans(X,K); 

    fcm_C1(i,:) = ctrs1(1,:); 
    fcm_C2(i,:) = ctrs1(2,:); 
    kmns_C1(i,:) = ctrs2(:,1); 
    kmns_C2(i,:) = ctrs2(:,2); 
end    

% C1_x(i,:) = [X(index1, 1) X(idx1==1,1)]; % cluster 1 yield strain
% C1_y(i,:) = [X(index1, 2) X(idx1==1,2)]; % cluster 1 yield stress
% C2_x(i,:) = [X(index1, 1) X(idx1==2,1)]; % cluster 2 yield strain
% C2_y(i,:) = [X(index1, 2) X(idx1==2,2)]; % cluster 2 yield stress