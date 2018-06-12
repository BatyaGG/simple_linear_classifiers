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

### Exercise 1

Run ```Pocket_vs_linear_analysis.m``` file, which generates random linear separator line and arranges 90 true (+1, -1) points and 10 outliers. There are implementations of pocket perceptron and linear regression algorithms, which are tested on 900 true and 100 outlier randomly generated datapoints.

Linear regression algorithm results in a weight **_W<sub>lin</sub>_**, which we obtain if we will minimize expected value of the squared error between our hypothesis and output _E<sub>out</sub>_. So in other words we need to find the hypothesis, which gives the smallest _E<sub>out</sub>_. But since labeling y comes from distribution P(y|x), which is unknown for us, we cannot estimate _E<sub>out</sub>_ and so we use _E<sub>in</sub>_ and comparative techniques.

<p align="center"> 
<img src="https://raw.githubusercontent.com/BatyaGG/simple_linear_classifiers/master/figures/regression.PNG" width="70%"> 
</p> 

so we minimize _E<sub>in</sub>(w)_ over all possible _**W**_ ∈ _R<sup>d + 1</sup>_, finding _**W<sub>lin</sub>**_ = _argminE<sub>in</sub>(**W**)_, which is a global min of derivative of _E<sub>in</sub>(W)_. Finally,

<p align="center">
  <i><b>W</b><sub>lin</sub> = ((x<sup><b>T</b></sup>x)<sup>-1</sup>x<sup>T</sup>)<b>Y</b></i>
</p>

Limitations of linear regression in data analysis: output must have linear correlation to all input dimensions and input dimensions needs to be independent of each other, noise must be approximated normally and have zero mean. Therefore, results of linear regressions are highly depended on outliers. Even few outliers may significantly degenerate resulting weights. Moreover, linear model may easily overfit since regression models noise together with true observations. Pocket and Linear Regression algorithms are compared in ```Pocket_vs_linear_analysis.m``` script in terms of _E<sub>out<sub>_. Pocket algorithm, compared to PLA may also be applied for non separable data, where it will give the result with less number of misclassified data points. Basically it is modified version of PLA, storing best weights with less _E<sub>in</sub>_. However it requires more computational time, because it iteratively updates weights, and compares them against previous best weights estimating _E<sub>in</sub>_ at each iteration.

<p align="center"> 
<img src="https://raw.githubusercontent.com/BatyaGG/simple_linear_classifiers/master/figures/lin_vs_pock1.PNG" width="70%">
<br>
<i>One of pocket vs linear regression comparison trials</i>
</p>

<p align="center"> 
<img src="https://raw.githubusercontent.com/BatyaGG/simple_linear_classifiers/master/figures/lin_vs_pock2.PNG" width="70%">
<br>
<i>E<sub>test</sub>(<b>W</b><sub>pocket</sub>) vs E<sub>test</sub>(<b>W</b><sub>lin</sub>) scatter plot</i>
</p>

After about 20 iterations, it can be concluded that pocket algorithm performs better in general having _E<sub>test</sub>_ concentrated between 0.1 and 0.13 in comparison to linear regression with _E<sub>test</sub>_ concentrated between 0.1 and 0.18.

### Exercise 2

Run ```LogisticAnalysis.m``` file, which also generates 10 outlier ans 90 true data points to train logistic regression algorithm implemented in the file. Testing was done on 100 outliers and 900 true data points. The script is an analysis of gradient descent algorithm for logistic regression.

This method uses logistic function: 𝜃 = _e<sup>s</sup> / 1 + e<sup>s</sup>_, which allows to get the 0-1 range. We have target function 

f(x) = P[**Y** = +1|X]

need to use the error measure used for logistic regression, which is based on the likehood.

<p align="center"> 
<img src="https://raw.githubusercontent.com/BatyaGG/simple_linear_classifiers/master/figures/logitstic_error.PNG">
</p>

To train logistic regression model, we need to find the gradient of _E<sub>in</sub>_ and set it to zero, which is not feasible analytically. But we can iteratively set it to zero, using gradient descent method.

Starting from some weights, the algorithm repeatedly takes small steps in the opposite direction of the gradient, reaching global minimum of gradient function. Before updating the weights data should be shuffled. Limitations of this algorithm are that sometimes it can just “dance around” global minimum and not converging. This happens when the learning rate is not properly chosen. Choosing big rate fastens the algorithm however results in unstable solution, making “dance around” problem. I've used fixed learning rate = 0.001, and 0 vector as an initial weights. Number of iterations was fixed to 2000 iteration limit.

<p align="center"> 
<img src="https://raw.githubusercontent.com/BatyaGG/simple_linear_classifiers/master/figures/logistic_space.PNG" width="70%">
<br>
<i>2D space with target function and generated function with test data</i>
</p>

<p align="center"> 
<img src="https://raw.githubusercontent.com/BatyaGG/simple_linear_classifiers/master/figures/logistic_weights.PNG" width="70%">
<br>
<i>Change of weights vs # iterations</i>
</p>
