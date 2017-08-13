# ml-classifiers
Run multiple machine learning binary classifiers (SVM, LDA, Decision Trees, KNN) from a single MATLAB script based on the Classfication Learner application.

```
    [trainedClassifier, validationScores, validationPredictions] = 
  	trainClassifier(trainingData,outcomeTrain,testingData,outcomeTest,headers,type)
  returns a trained classifier and its accuracy. This code recreates the
  classification model trained in Classification Learner app. Use the
  generated code to automate training the same model with new data, or to
  learn how to programmatically train models.
 
   Input:
       trainingData: rows are observations and columns are predictors.
       outcomeTrain: contains the binary outcome of trainingData.
       testingData : contains test examples formatted like trainingData.
       outcomeTest : contains the binary outcome of testingData.
       headers     : contains the names of each predictor. If left empty
       generic names are created.
       type        : is the name of classifier to run. The set is
       {'linearSVM' 'cubicSVM' 'quadraticSVM' 'fineGaussianSVM'
       'mediumGaussianSVM' 'coarseGaussianSVM' 'linearDisc' 'quadraticDisc'
       'simpleTree' 'mediumTree' 'complexTree' 'RUSBoostedTrees' 'ensembleBoostedTrees' 
       'ensembleBaggedTrees' 'fineKNN' 'mediumKNN' 'coarseKNN' 'cosineKNN' 
       'cubicKNN' 'weightedKNN'}  
 
   Output:
       trainedClassifier: a struct containing the trained classifier. The
        struct contains various fields with information about the trained
        classifier.
 
       trainedClassifier.predictFcn: a function to make predictions on new
        data.
 
       validationScores: a two-column prediction for each class (first
       column == class 0, second column == class 1)
 
       validationPredictions: a vector with class predictions.
 
```

## Example

Here's an example to run:

```
load fisheriris
inds = ~strcmp(species,'setosa');
X = meas(inds,3:4);
y = species(inds);
y = single(ismember(y,'versicolor'));

[trainClassifier, validationScores, validationPredictions] = trainClassifier(X,y,X,y,{'var1'; 'var2'},{'linearSVM'});
```

Tested on MATLAB 2017a.
