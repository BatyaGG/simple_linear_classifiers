% Batyrkhan Saduanov
% Generates 100 training data set with 10 outliers. Compares test-sample
% errors of pocket and linear regression algorithms plotting them as a scatter
% plot versus each other and plots their functions on the same plot.
% Learning is done on set of 100 supervised data points with 10 outliers
% and tested on set of 1000 test data points with 100 outliers.
% Wait some seconds until scatter error plot appears.
% If MATLAB detects error rerun the function
clear
%% Data generation
% Creating n random linearly divisible data points and m outliers in two
% dimensions for training
m = 10;
n = 90;
x1 = 100*randn(n+m,1);
x2 = 100*randn(n+m,1);

% Coefficients of target function f = a*x1 + b*x2+c
a = 1;
b = -1;
c = 5;

% Yes and No points' index arrangment
trueCount = 1;
falseCount = 1;
for k = 1:n
    if a*x1(k)+b*x2(k)+c>0
        Y(k) = 1;
        trueIndex(trueCount) = k;
        trueCount = trueCount+1;
    else
        Y(k) = -1;
        falseIndex(falseCount) = k;
        falseCount = falseCount+1;
    end
end

% Outliers arrangement
for k = n+1:n+m
    if a*x1(k)+b*x2(k)+c>0
        Y(k) = -1;
        falseIndex(falseCount) = k;
        falseCount = falseCount+1;
    else
        Y(k) = 1;
        trueIndex(trueCount) = k;
        trueCount = trueCount+1;
    end
end

% Creating ntest random linearly divisible data points and mtest outliers in two
% dimensions for testing
mtest = 100;
ntest = 900;
x1test = 100*randn(ntest+mtest,1);
x2test = 100*randn(ntest+mtest,1);

% Yes and No points' index arrangment
trueCounttest = 1;
falseCounttest = 1;
for k = 1:ntest
    if a*x1test(k)+b*x2test(k)+c>0
        Ytest(k) = 1;
        trueIndextest(trueCounttest) = k;
        trueCounttest = trueCounttest+1;
    else
        Ytest(k) = -1;
        falseIndextest(falseCounttest) = k;
        falseCounttest = falseCounttest+1;
    end
end

% Outliers arrangement
for k = ntest+1:ntest+mtest
    if a*x1test(k)+b*x2test(k)+c>0
        Ytest(k) = -1;
        falseIndextest(falseCounttest) = k;
        falseCounttest = falseCounttest+1;
    else
        Ytest(k) = 1;
        trueIndextest(trueCounttest) = k;
        trueCounttest = trueCounttest+1;
    end
end

Xtest = [ones(length(x1test),1) x1test x2test];

%% Pocket algorithm with numit number of iterations
numit = 20000;
error = realmax;
% Creating an input X vector and weights W vector
X = [ones(length(x1),1) x1 x2]';
W = randn(3,1);
% Pocket learning algorithm
index = linspace(1,n+m,n+m);
index = index(randperm(n+m));
k=1;
correct = 0;
for i = 0:numit
    curInd = index(k);
    S = W'*X(:,curInd);
    if Y(curInd)*S <= 0
        W = W + Y(curInd)*X(:,curInd);
        Sign = W'*X;
        errornew = length(find(Y.*Sign<0));
        if errornew < error
            PocketW = W;
            error = errornew;
        end
    end
    if k<n
        k=k+1;
    else
        k=1;
    end
end
error1 = length(find(Ytest.*(PocketW'*Xtest')<0))/(mtest+ntest);

%% Linear regression algorithm
% Creating an input X vector and weights W vector
X = [ones(length(x1),1) x1 x2];
Wlin = randn(3,1);
% Linear regression learning algorithm
Wlin = (inv(X'*X)*X')*Y';
Sign = Wlin'*Xtest';
error = length(find(Ytest.*Sign<0));
error2 = error/(mtest+ntest);

%% Plotting
figure()
plot(x1test(trueIndextest),x2test(trueIndextest),'bo', 'MarkerSize', 8); hold on
plot(x1test(falseIndextest),x2test(falseIndextest),'rX', 'MarkerSize', 8);
plot(linspace(-300,300,600)',(-c-a*linspace(-300,300,600)')./b, 'g-', 'LineWidth', 3);
plot(linspace(-300,300,600)',(-PocketW(1)-PocketW(2)*linspace(-300,300,600)')./PocketW(3), 'm--', 'LineWidth', 3);
plot(linspace(-300,300,600)',(-Wlin(1)-Wlin(2)*linspace(-300,300,600)')./Wlin(3), 'c--', 'LineWidth', 3);
hold off;
legend('+1','-1','Target function f','Pocket function','Linear Regression function');
xlabel('x1');
ylabel('x2');
grid on
Str1 = 'Epocket is: ';
Str1 = strcat(Str1,num2str(error1));
Str2 = 'Elinear is: ';
Str2 = strcat(Str2,num2str(error2));
S = {Str1; Str2};
title(S);

figure()
for i=1:100
clear
%% Data generation
% Creating n random linearly divisible data points and m outliers in two
% dimensions for training
m = 10;
n = 90;
x1 = 100*randn(n+m,1);
x2 = 100*randn(n+m,1);

% Coefficients of target function f = a*x1 + b*x2+c
a = 1;
b = -1;
c = 5;

% Yes and No points' index arrangment
trueCount = 1;
falseCount = 1;
for k = 1:n
    if a*x1(k)+b*x2(k)+c>0
        Y(k) = 1;
        trueIndex(trueCount) = k;
        trueCount = trueCount+1;
    else
        Y(k) = -1;
        falseIndex(falseCount) = k;
        falseCount = falseCount+1;
    end
end

% Outliers arrangement
for k = n+1:n+m
    if a*x1(k)+b*x2(k)+c>0
        Y(k) = -1;
        falseIndex(falseCount) = k;
        falseCount = falseCount+1;
    else
        Y(k) = 1;
        trueIndex(trueCount) = k;
        trueCount = trueCount+1;
    end
end

% Creating ntest random linearly divisible data points and mtest outliers in two
% dimensions for testing
mtest = 100;
ntest = 900;
x1test = 100*randn(ntest+mtest,1);
x2test = 100*randn(ntest+mtest,1);

% Yes and No points' index arrangment
trueCounttest = 1;
falseCounttest = 1;
for k = 1:ntest
    if a*x1test(k)+b*x2test(k)+c>0
        Ytest(k) = 1;
        trueIndextest(trueCounttest) = k;
        trueCounttest = trueCounttest+1;
    else
        Ytest(k) = -1;
        falseIndextest(falseCounttest) = k;
        falseCounttest = falseCounttest+1;
    end
end

% Outliers arrangement
for k = ntest+1:ntest+mtest
    if a*x1test(k)+b*x2test(k)+c>0
        Ytest(k) = -1;
        falseIndextest(falseCounttest) = k;
        falseCounttest = falseCounttest+1;
    else
        Ytest(k) = 1;
        trueIndextest(trueCounttest) = k;
        trueCounttest = trueCounttest+1;
    end
end
Xtest = [ones(length(x1test),1) x1test x2test];
%% Pocket algorithm with numit number of iterations
numit = 20000;
error = realmax;
% Creating an input X vector and weights W vector
X = [ones(length(x1),1) x1 x2]';
W = randn(3,1);
% Pocket learning algorithm
index = linspace(1,n,n);
index = index(randperm(n));
k=1;
correct = 0;
for i = 0:numit
    curInd = index(k);
    S = W'*X(:,curInd);
    if Y(curInd)*S <= 0
        W = W + Y(curInd)*X(:,curInd);
        Sign = W'*X;
        errornew = length(find(Y.*Sign<0));
        if errornew < error
            PocketW = W;
            error = errornew;
        end
    end
    if k<n
        k=k+1;
    else
        k=1;
    end
end
error1 = length(find(Ytest.*(PocketW'*Xtest')<0))/(mtest+ntest);
%% Linear regression algorithm
% Creating an input X vector and weights W vector
X = [ones(length(x1),1) x1 x2];
Wlin = randn(3,1);
% Linear regression learning algorithm
Wlin = (inv(X'*X)*X')*Y';
Sign = Wlin'*Xtest';
error = length(find(Ytest.*Sign<0));
error2 = error/(mtest+ntest);
%% Plot
plot(error2,error1,'.'); hold on
end
xlabel('Etest(Wlin)');
ylabel('Etest(Wpocket)');
title('Etest(Wpocket) vs Etest(Wlin)');
grid on