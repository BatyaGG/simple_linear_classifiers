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

Linear regression algorithm results in a weight (w_lin), which we obtain if we will minimize expected value of the squared error between our hypothesis and output (E_out). So in other words we need to find the hypothesis, which gives the smallest (E_out). But since labeling y comes from distribution P(y|x), which is unknown for us, we cannot estimate E_out and so we use E_in and comparative techniques.

<p align="center"> 
<img src="https://raw.githubusercontent.com/BatyaGG/simple_linear_classifiers/master/figures/regression.PNG" width="70%"> 
</p> 

so we minimize _E<sub>in</sub>(w)_ 
