% Batyrkhan Saduanov
% Studies the dependensies of iteration number to logistic algorithm
% performance in generalization. Studies dependensies of gradient functions
% at different t->T and their effect on Ein and Etest. Studies the
% behaviour of weights W improvements and proves that it behaves linearly.
% Plots test points, target function and hypothesis of logistic regression.
% Learning is done on supervised training data set of size 100 with 10 outliers,
% tested on set of size 1000 with 100 outliers.
clear
%% Data generation
% Creating n random linearly divisible data points and m outliers in two
% dimensions for training
m = 10;
n = 90;
x1 = 100*randn(n+m,1);
x2 = 100*randn(n+m,1);

% Coefficients of target function f = a*x1 + b*x2+c
a = -1;
b = 1;
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

Xtest = [ones(length(x1test),1) x1test x2test]';

%% Logistic Regression algorithm
numit = 2000;
rate = 0.001;
Ein = [];
% Creating an input X vector and weights W vector
X = [ones(length(x1),1) x1 x2]';
W = [0;0;0];

% Logistic learning algorithm
index = linspace(1,n+m,n+m);
index = index(randperm(n+m));
k=1;

for i=1:numit
    curInd = index(k);
    dE(:,i) = (Y(k)*X(:,k))/(1+exp(-W'*X(:,k)));
    W = W - rate*dE(:,i);
    if k<n+m
        k=k+1;
    else
        k=1;
    end
Signalin = max(abs(W'*X));
Signalin = W'*X./Signalin;
Signalout = max(abs(W'*Xtest));
Signalout = W'*Xtest./Signalout;
Ecur = log(1+exp(-Y.*Signalin));
Ecur = mean(Ecur);
Ein(i) = 1-Ecur;
Ecur = log(1+exp(-Ytest.*Signalout));
Ecur = mean(Ecur);
Eout(i) = 1-Ecur;
Wall(:,i) = W;
end

%% Plotting
figure()
subplot(3,1,1)
plot(Wall(1,:))
title('Change of W0 by iterations')
ylabel('W0')
grid on
subplot(3,1,2)
plot(Wall(2,:))
title('Change of W1 by iterations')
ylabel('W1')
grid on
subplot(3,1,3)
plot(Wall(3,:))
title('Change of W2 by iterations')
xlabel('Iterations (t)')
ylabel('W2')
grid on
figure()
subplot(3,2,[1,3,5])
plot(Ein,'r.');hold on
plot(Eout,'b.'); hold off
legend('Ein','Eout')
title('Errors vs t->T (iterations)')
xlabel('Iterations(t)')
ylabel('Errors')
grid on
subplot(3,2,2)
plot(dE(1,:),'-')
title('W0 gradient vs t->T (iterations)')
ylabel('dW0')
grid on
subplot(3,2,4)
plot(dE(2,:),'-')
title('W1 gradient vs t->T (iterations)')
ylabel('dW1')
grid on
subplot(3,2,6)
plot(dE(3,:),'-')
title('W2 gradient vs t->T (iterations)')
xlabel('Iterations(t)')
ylabel('dW2')
grid on
figure()
plot(x1test(trueIndextest),x2test(trueIndextest),'bo', 'MarkerSize', 8); hold on
plot(x1test(falseIndextest),x2test(falseIndextest),'rX', 'MarkerSize', 8);
plot(linspace(-300,300,600)',(-c-a*linspace(-300,300,600)')./b, 'g-', 'LineWidth', 3);
plot(linspace(-300,300,600)',(-W(1)-W(2)*linspace(-300,300,600)')./W(3), 'black--', 'LineWidth', 3);
hold off;
legend('+1','-1','Target function f','Generated function g');
xlabel('x1');
ylabel('x2');
title('Logistic Regression');
grid on