% Batyrkhan Saduanov
% Algorithm studies cross validation errors of supervised data set of 1000
% points with 100 outliers. Data set is divided into 10 equally sized
% subsets, each of which is used as a training set iteratively. In each
% iteration, other data points (except learning ones) are used as an
% testing data. Finally all 10 cross validation errors are plotted and
% average error is computed. Cross validation is done on pocket, linear and
% logistic learning algorithms, with final plot of their functions, target function
% and whole data set.
clear
%% Data generation
% Creating n random linearly divisible data points and m outliers in two dimensions
m = 100;
n = 900;
x1 = 100*randn(n+m,1);
x2 = 100*randn(n+m,1);

% Coefficients of target function f = a*x1 + b*x2+c
a = 1;
b = -1;
c = 5;

% Yes and No points' index arrangment
for k = 1:n
    if a*x1(k)+b*x2(k)+c>0
        Y(k) = 1;
    else
        Y(k) = -1;
    end
end

for k = n+1:n+m
    if a*x1(k)+b*x2(k)+c>0
        Y(k) = -1;
    else
        Y(k) = 1;
    end
end
perm = randperm(n+m);
x1 = x1(perm);
x2 = x2(perm);
Y = Y(perm);

%% Linear regression algorithm
for i = 1:10
    % Creating an input X vector and weights W vector
    ind = [((i-1)*100+1):(1000-(10-i)*100)];
    Xin = [ones(100,1) x1(ind) x2(ind)];
    Yin = Y(ind);
    x1temp = x1;
    x2temp = x2;
    Ytemp = Y;
    x1temp(ind) = [];
    x2temp(ind) = [];
    Ytemp(ind) = [];
    Xout = [ones(900,1) x1temp x2temp];
    Yout = Ytemp;
    W = randn(3,1);
    % Linear regression learning algorithm
    Wlin = (inv(Xin'*Xin)*Xin')*Yin';
    Signal = Wlin'*Xout';
    E(i) = length(find(Yout.*Signal<0));
    Elin(i) = E(i)/900;
end

%% Pocket algorithm
error = realmax;
% Creating an input X vector and weights W vector
for i = 1:10
    ind = [((i-1)*100+1):(1000-(10-i)*100)];
    Xin = [ones(100,1) x1(ind) x2(ind)]';
    Yin = Y(ind);
    x1temp = x1;
    x2temp = x2;
    Ytemp = Y;
    x1temp(ind) = [];
    x2temp(ind) = [];
    Ytemp(ind) = [];
    Xout = [ones(900,1) x1temp x2temp]';
    Yout = Ytemp;
    W = randn(3,1);
    % Perceptron learning algorithm
    index = linspace(1,100,100);
    index = index(randperm(100));
    k=1;
    for j = 1:2000
        curInd = index(k);
        S = W'*Xin(:,curInd);
        if Yin(curInd)*S <= 0
            W = W + Yin(curInd)*Xin(:,curInd);
            Sign = W'*Xin;
            errornew = length(find(Yin.*Sign<0));
            if errornew < error
                PocketW = W;
                error = errornew;
            end
        end
        if k<100
            k=k+1;
        else
            k=1;
        end
    end
Signal = PocketW'*Xout;
E(i) = length(find(Yout.*Signal<0));
Epocket(i) = E(i)/900;
end

%% Logistic Regression algorithm
rate = 0.001;
for i = 1:10
    % Creating an input X vector and weights W vector
    ind = [((i-1)*100+1):(1000-(10-i)*100)];
    Xin = [ones(100,1) x1(ind) x2(ind)]';
    Yin = Y(ind);
    x1temp = x1;
    x2temp = x2;
    Ytemp = Y;
    x1temp(ind) = [];
    x2temp(ind) = [];
    Ytemp(ind) = [];
    Xout = [ones(900,1) x1temp x2temp]';
    Yout = Ytemp;
    Wlog = [0;0;0];

    % Logistic learning algorithm
    index = linspace(1,100,100);
    index = index(randperm(100));
    k=1;
    for j=1:2000
        curInd = index(k);
        dE(:,i) = (Yin(curInd)*Xin(:,curInd))/(1+exp(-Wlog'*Xin(:,curInd)));
        Wlog = Wlog - rate*dE(:,i);
        if k<100
            k=k+1;
        else
            k=1;
        end
    end
Signal = Wlog'*Xout;
E(i) = length(find(Yout.*Signal<0));
Elog(i) = E(i)/900;
end
%% Plotting
figure()
subplot(1,3,1)
plot(Elin,'m-','LineWidth',3)
Str = 'Average error is: ';
Str = strcat(Str,num2str(mean(Elin)));
S = {'Validation error function of linear regression'; Str};
title(S)
xlabel('#validation')
ylabel('Eval')
grid on
subplot(1,3,2)
plot(Epocket,'c-','LineWidth',3)
Str = 'Average error is: ';
Str = strcat(Str,num2str(mean(Epocket)));
S = {'Validation error function of pocket algorithm'; Str};
title(S)
xlabel('#validation')
grid on
subplot(1,3,3)
plot(Elog,'y-','LineWidth',3)
Str = 'Average error is: ';
Str = strcat(Str,num2str(mean(Elog)));
S = {'Validation error function of logistic regression'; Str};
title(S)
xlabel('#validation')
grid on
figure()
plot(x1(find(Y==1)),x2(find(Y==1)),'bo', 'MarkerSize', 8); hold on
plot(x1(find(Y==-1)),x2(find(Y==-1)),'rX', 'MarkerSize', 8);
plot(linspace(-300,300,600)',(-c-a*linspace(-300,300,600)')./b, 'g-', 'LineWidth', 3);
plot(linspace(-300,300,600)',(-PocketW(1)-PocketW(2)*linspace(-300,300,600)')./PocketW(3), 'c--', 'LineWidth', 3);
plot(linspace(-300,300,600)',(-Wlin(1)-Wlin(2)*linspace(-300,300,600)')./Wlin(3), 'm--', 'LineWidth', 3);
plot(linspace(-300,300,600)',(-Wlog(1)-Wlog(2)*linspace(-300,300,600)')./Wlog(3), 'y--', 'LineWidth', 3);
hold off;
legend('+1','-1','Target function f','Generated pocket function g','Generated linear regression function g','Generated logistic regression function g');
xlabel('x1');
ylabel('x2');
title('Three algorithms');
grid on