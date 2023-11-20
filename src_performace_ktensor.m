

clear
maxNumCompThreads(1);

% initialize
tals = struct; tpinv = struct; tqr = struct; tpw = struct;

%% 7-way
% generate tensor
d = 7;


r = 7;
n = [10000,15000,30000];
maxiter = 10;
tol = 1e-10;


Uinit = cell(d,1);

tals.r7 = zeros(length(n),5);
tpinv.r7 = zeros(length(n),5);
tqr.r7 = zeros(length(n),7);
tsvd.r7 = zeros(length(n),7);

for i = 1:length(n)
    nk = n(i);
    T = sinsum_full(d,nk);
    % initial guess
    for j = 1:d
        Uinit{j} = rand(nk,r);
    end
    
    % compute CP
    [Mqr7,~,outqr7] = cp_als_qr(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Msvd7,~,outpw7] = cp_als_qr_new(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Mals7,~,outals7] = cp_als_time(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');

     % compute average iteration time
    tqr.r7(i,:) = mean(outqr7.times(2:end,:),1);
    tpw.r7(i,:) = mean(outpw7.times(2:end,:),1);
    tals.r7(i,:) = mean(outals7.times(2:end,:),1);
end
%% data prep
nals7 = zeros(3,6);
nqr7 = zeros(3,6);
npw7 = zeros(3,6);
for i = 1:3
    nals7(i,:) = [tals.r7(i,1), tals.r7(i,2),0,0,tals.r7(i,3),tals.r7(i,4)+tals.r7(i,5)];
    nqr7(i,:) = [tqr.r7(i,1),tqr.r7(i,2),tqr.r7(i,3),tqr.r7(i,4),tqr.r7(i,5),(tqr.r7(i,6)+tqr.r7(i,7))];
    npw7(i,:) = [tpw.r7(i,1),tpw.r7(i,2),tpw.r7(i,3),tpw.r7(i,4),tpw.r7(i,5),(tpw.r7(i,6)+tpw.r7(i,7))];

end



%% 3 Way


d = 3;


r = 3;
n = [10000,15000,30000];
maxiter = 10;
tol = 1e-10;


Uinit = cell(d,1);

tals.r3 = zeros(length(n),5);
tpinv.r3 = zeros(length(n),5);
tqr.r3 = zeros(length(n),7);
tsvd.r3 = zeros(length(n),7);

for i = 1:length(n)
    nk = n(i);
    T = sinsum_full(d,nk);
    % initial guess
    for j = 1:d
        Uinit{j} = rand(nk,r);
    end
    
    % compute CP
    [Mqr3,~,outqr3] = cp_als_qr(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Msvd3,~,outpw3] = cp_als_qr_new(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Mals3,~,outals3] = cp_als_time(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');

     % compute average iteration time
    tqr.r3(i,:) = mean(outqr3.times(2:end,:),1);
    tpw.r3(i,:) = mean(outpw3.times(2:end,:),1);
    tals.r3(i,:) = mean(outals3.times(2:end,:),1);
end
%% data prep
nals3 = zeros(3,6);
nqr3 = zeros(3,6);
npw3 = zeros(3,6);
for i = 1:3
    nals3(i,:) = [tals.r3(i,1), tals.r3(i,2),0,0,tals.r3(i,3),tals.r3(i,4)+tals.r3(i,5)];
    nqr3(i,:) = [tqr.r3(i,1),tqr.r3(i,2),tqr.r3(i,3),tqr.r3(i,4),tqr.r3(i,5),(tqr.r3(i,6)+tqr.r3(i,7))];
    npw3(i,:) = [tpw.r3(i,1),tpw.r3(i,2),tpw.r3(i,3),tpw.r3(i,4),tpw.r3(i,5),(tpw.r3(i,6)+tpw.r3(i,7))];

end


%% 5 way
d = 5;


r = 5;
n = [10000,15000,30000];
maxiter = 10;
tol = 1e-10;


Uinit = cell(d,1);

tals.r5 = zeros(length(n),5);
tpinv.r5 = zeros(length(n),5);
tqr.r5 = zeros(length(n),7);
tsvd.r5 = zeros(length(n),7);

for i = 1:length(n)
    nk = n(i);
    T = sinsum_full(d,nk);
    % initial guess
    for j = 1:d
        Uinit{j} = rand(nk,r);
    end
    
    % compute CP
    [Mqr5,~,outqr5] = cp_als_qr(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Msvd5,~,outpw5] = cp_als_qr_new(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Mals5,~,outals5] = cp_als_time(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');

     % compute average iteration time
    tqr.r5(i,:) = mean(outqr5.times(2:end,:),1);
    tpw.r5(i,:) = mean(outpw5.times(2:end,:),1);
    tals.r5(i,:) = mean(outals5.times(2:end,:),1);
end
%% data prep
nals5 = zeros(3,6);
nqr5 = zeros(3,6);
npw5 = zeros(3,6);
for i = 1:3
    nals5(i,:) = [tals.r5(i,1), tals.r5(i,2),0,0,tals.r5(i,3),(tals.r5(i,4)+tals.r5(i,5))];
    nqr5(i,:) = [tqr.r5(i,1),tqr.r5(i,2),tqr.r5(i,3),tqr.r5(i,4),tqr.r5(i,5),(tqr.r5(i,6)+tqr.r5(i,7))];
    npw5(i,:) = [tpw.r5(i,1),tpw.r5(i,2),tpw.r5(i,3),tpw.r5(i,4),tpw.r5(i,5),(tpw.r5(i,6)+tpw.r5(i,7))];

end

%% 9-way
% generate tensor
d = 9;


r = 9;
n = [10000,15000,30000];
maxiter = 10;
tol = 1e-10;


Uinit = cell(d,1);

tals.r9 = zeros(length(n),5);
tpinv.r9 = zeros(length(n),5);
tqr.r9 = zeros(length(n),7);
tsvd.r9 = zeros(length(n),7);

for i = 1:length(n)
    nk = n(i);
    T = sinsum_full(d,nk);
    % initial guess
    for j = 1:d
        Uinit{j} = rand(nk,r);
    end
    
    % compute CP
    %[Mqr9,~,outqr9] = cp_als_qr(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Msvd9,~,outpw9] = cp_als_qr_new(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');
    [Mals9,~,outals9] = cp_als_time(T,r,'init',Uinit,'maxiters',maxiter,'tol',tol,'printitn',1,'errmethod','fast');

     % compute average iteration time
    %tqr.r9(i,:) = mean(outqr9.times(2:end,:),1);
    tpw.r9(i,:) = mean(outpw9.times(2:end,:),1);
    tals.r9(i,:) = mean(outals9.times(2:end,:),1);
end
%% data prep
nals9 = zeros(3,6);
nqr9 = zeros(3,6);
npw9 = zeros(3,6);
for i = 1:3
    nals9(i,:) = [tals.r9(i,1), tals.r9(i,2),0,0,tals.r9(i,3),tals.r9(i,4)+tals.r9(i,5)];
    %nqr9(i,:) = [tqr.r9(i,1),tqr.r9(i,2),tqr.r9(i,3),tqr.r9(i,4),tqr.r9(i,5),(tqr.r9(i,6)+tqr.r9(i,7))];
    nqr9(i,:) = [0,0,0,0,0,0];
    npw9(i,:) = [tpw.r9(i,1),tpw.r9(i,2),tpw.r9(i,3),tpw.r9(i,4),tpw.r9(i,5),(tpw.r9(i,6)+tpw.r9(i,7))];

end






%% prep data
sdata7 = [];
for i = 1:3
    sdata7 = [sdata7; npw7(i,:);nals7(i,:);nqr7(i,:); zeros(1,6)];
end

sdata3 = [];
for i = 1:3
    sdata3 = [sdata3; npw3(i,:);nals3(i,:);nqr3(i,:); zeros(1,6)];
end

sdata5 = [];
for i = 1:3
    sdata5 = [sdata5; npw5(i,:);nals5(i,:);nqr5(i,:); zeros(1,6)];
end

sdata9 = [];
for i = 1:3
    sdata9 = [sdata9; npw9(i,:); nals9(i,:);nqr9(i,:); zeros(1,6)];
end


%% plot data
kt_data = struct;
kt_data.sdata7 = sdata7;
kt_data.sdata5 = sdata5;
kt_data.sdata3 = sdata3;   
kt_data.sdata9 = sdata9;
save('kt_data.mat','kt_data');

