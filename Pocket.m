% Batyrkhan Saduanov
% PLA
clear
%% Data generation

numit = 1000;

% Creating n random linearly divisible data points and m outliers in two dimensions
m = 200;
n = 300;
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

%% Perceptron algorithm
error = realmax;
% Creating an input X vector and weights W vector
X = [ones(length(x1),1) x1 x2]';
W = randn(3,1);
% Perceptron learning algorithm
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
error = error/(m+n);
%% Plotting
figure()
plot(x1(trueIndex),x2(trueIndex),'bo', 'MarkerSize', 8); hold on
plot(x1(falseIndex),x2(falseIndex),'rX', 'MarkerSize', 8);
plot(linspace(-300,300,600)',(-c-a*linspace(-300,300,600)')./b, 'g-', 'LineWidth', 3);
plot(linspace(-300,300,600)',(-PocketW(1)-PocketW(2)*linspace(-300,300,600)')./PocketW(3), 'black--', 'LineWidth', 3);
hold off;
legend('+1','-1','Target function f','Generated function g');
xlabel('x1');
ylabel('x2');
Str = 'Error is: ';
Str = strcat(Str,num2str(error));
S = {'Pocket Algorithm'; Str};
title(S);