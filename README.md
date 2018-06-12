# Linear classificators implementation and analysis

MATLAB implementation of least-squares linear regression, pocket perceptron and logistic regression algorithms. Consists of 3 performance analysis subtasks.

<p align="center"> 
<img src="https://raw.githubusercontent.com/BatyaGG/simple_linear_classifiers/master/figures/main.PNG" width="90%"> 
</p> 

## References

Abu-Mostafa Y. S., Magdon-Ismail M., Lin H. T. Learning from data. – New York, NY, USA: : AMLBook, 2012. – Т. 4.
https://work.caltech.edu/telecourse.html

## Usage

Clone the project.

Run ```Pocket_vs_linear_analysis.m``` file, which generates random linear separator line and arranges 90 true (+1, -1) points and 10 outliers. There are implementations of pocket perceptron and linear regression algorithms, which are tested on 900 true and 100 outlier randomly generated datapoints.

```
%% Linear regression algorithm
% Creating an input X vector and weights W vector
X = [ones(length(x1),1) x1 x2];
Wlin = randn(3,1);
% Linear regression learning algorithm
Wlin = (inv(X'*X)*X')*Y';
Sign = Wlin'*Xtest';
error = length(find(Ytest.*Sign<0));
error2 = error/(mtest+ntest);
```
