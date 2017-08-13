function [trainedClassifier,validationScores,validationPredictions] = trainClassifier(trainingData,outcomeTrain,testingData,outcomeTest,headers,type)
% [trainedClassifier, validationAccuracy, validationPredictions] = 
% 	trainClassifier(trainingData,outcomeTrain,testingData,outcomeTest,headers,type)
% returns a trained classifier and its accuracy. This code recreates the
% classification model trained in Classification Learner app. Use the
% generated code to automate training the same model with new data, or to
% learn how to programmatically train models.
%
%  Input:
%      trainingData: rows are observations and columns are predictors.
%      outcomeTrain: contains the binary outcome of trainingData.
%      testingData : contains test examples formatted like trainingData.
%      outcomeTest : contains the binary outcome of testingData.
%      headers     : contains the names of each predictor. If left empty
%      generic names are created.
%      type        : is the name of classifier to run. The set is
%      {'linearSVM' 'cubicSVM' 'quadraticSVM' 'fineGaussianSVM'
%      'mediumGaussianSVM' 'coarseGaussianSVM' 'linearDisc' 'quadraticDisc'
%      'simpleTree' 'mediumTree' 'complexTree' 'RUSBoostedTrees' 'ensembleBoostedTrees' 
%      'ensembleBaggedTrees' 'fineKNN' 'mediumKNN' 'coarseKNN' 'cosineKNN' 
%      'cubicKNN' 'weightedKNN'}  
%
%  Output:
%      trainedClassifier: a struct containing the trained classifier. The
%       struct contains various fields with information about the trained
%       classifier.
%
%      trainedClassifier.predictFcn: a function to make predictions on new
%       data.
%
%      validationScores: a two-column prediction for each class (first
%      column == class 0, second column == class 1)
%
%      validationPredictions: a vector with class predictions.
%

% Auto-generated by MATLAB on 10-Aug-2017 16:43:48
% Edited by: Tuka Alhanai and Mohammad Ghassemi - Aug 2017

%% INIT VARS
if ~exist('headers','var')
    for i = 1:size(X_train,1)
    headers(i,1) = {strcat(['headers_x', num2str(i)])};
    end
end

%% INITIALIZE TRAINING
% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
% Convert input to table
% inputTable = array2table(trainingData, 'VariableNames', {'column_1', 'column_2', 'column_3', 'column_4'});

inputTable = array2table([trainingData outcomeTrain], 'VariableNames', [headers; {'outcome'}]);

% predictorNames = {'column_1', 'column_2', 'column_3'};
predictorNames = headers;

predictors = inputTable(:, predictorNames);
response   = outcomeTrain;
% response = inputTable.column_4;
% isCategoricalPredictor = [false, false, false];

%% TRAIN CLASSIFIER
% This code specifies all the classifier options and trains the classifier.
if strmatch(type,'quadraticSVM','exact')
    
    classification = fitcsvm(...
        predictors, ...
        response, ...
        'KernelFunction', 'polynomial', ...
        'PolynomialOrder', 2, ...
        'KernelScale', 'auto', ...
        'BoxConstraint', 1, ...
        'Standardize', true, ...
        'ClassNames', [0; 1]);
    
elseif strmatch(type,'mediumGaussianSVM','exact')
    
    classification = fitcsvm(...
        predictors, ...
        response, ...
        'KernelFunction', 'gaussian', ...
        'PolynomialOrder', [], ...
        'KernelScale', 3.2, ...
        'BoxConstraint', 1, ...
        'Standardize', true, ...
        'ClassNames', [0; 1]);

elseif strmatch(type,'coarseGaussianSVM','exact')

    classification = fitcsvm(...
        predictors, ... 
        response, ...
        'KernelFunction', 'gaussian', ...
        'PolynomialOrder', [], ...
        'KernelScale', 13, ...
        'BoxConstraint', 1, ...
        'Standardize', true, ... 
        'ClassNames', [0; 1]);
    
elseif strmatch(type,'fineGaussianSVM','exact')
    
    classification = fitcsvm(...
        predictors, ...
        response, ...
        'KernelFunction', 'gaussian', ...
        'PolynomialOrder', [], ...
        'KernelScale', 0.79, ...
        'BoxConstraint', 1, ...
        'Standardize', true, ...
        'ClassNames', [0; 1]);

elseif strmatch(type,'cubicSVM','exact')

    classification = fitcsvm(...
        predictors, ...
        response, ...
        'KernelFunction', 'polynomial', ...
        'PolynomialOrder', 3, ...
        'KernelScale', 'auto', ...
        'BoxConstraint', 1, ...
        'Standardize', true, ...
        'ClassNames', [0; 1]);

elseif strmatch(type,'linearSVM','exact')

    classification = fitcsvm(...
        predictors, ...
        response, ...
        'KernelFunction', 'linear', ...
        'PolynomialOrder', [], ...
        'KernelScale', 'auto', ...
        'BoxConstraint', 1, ...
        'Standardize', true, ...
        'ClassNames', [single(0); single(1)]);

elseif strmatch(type,'linearDisc','exact')
    
    classification = fitcdiscr(...
        predictors, ...
        response, ...
        'DiscrimType', 'diagLinear', ...
        'FillCoeffs', 'off', ...
        'SaveMemory', 'on', ...
        'ClassNames', [0; 1]);

elseif strmatch(type,'quadraticDisc','exact')
    
    classification = fitcdiscr(...
    predictors, ...
    response, ...
    'DiscrimType', 'diagQuadratic', ...
    'FillCoeffs', 'off', ...
    'SaveMemory', 'on', ...
    'ClassNames', [0; 1]);

elseif strmatch(type,'simpleTree','exact')
    
    classification = fitctree(...
        predictors, ...
        response, ...
        'SplitCriterion', 'gdi', ...
        'MaxNumSplits', 4, ...
        'Surrogate', 'off', ...
        'ClassNames', [0; 1]);

elseif strmatch(type,'mediumTree','exact')
    
    classification = fitctree(...
    predictors, ...
    response, ...
    'SplitCriterion', 'gdi', ...
    'MaxNumSplits', 20, ...
    'Surrogate', 'off', ...
    'ClassNames', [0; 1]);

elseif strmatch(type,'complexTree','exact')

classification = fitctree(...
    predictors, ...
    response, ...
    'SplitCriterion', 'gdi', ...
    'MaxNumSplits', 100, ...
    'Surrogate', 'off', ...
    'ClassNames', [0; 1]);

elseif strmatch(type,'RUSBoostedTrees','exact')
    
    template = templateTree(...
        'MaxNumSplits', 20);
    classification = fitensemble(...
        predictors, ...
        response, ...
        'RUSBoost', ...
        30, ...
        template, ...
        'Type', 'Classification', ...
        'LearnRate', 0.1, ...
        'ClassNames', [0; 1]);
    
elseif strmatch(type,'ensembleBoostedTrees','exact')
    
    template = templateTree(...
        'MaxNumSplits', 20);
    classification = fitensemble(...
        predictors, ...
        response, ...
        'AdaBoostM1', ...
        30, ...
        template, ...
        'Type', 'Classification', ...
        'LearnRate', 0.1, ...
        'ClassNames', [0; 1]);
    
elseif strmatch(type,'ensembleBaggedTrees','exact')

    classification = fitensemble(...
        predictors, ...
        response, ...
        'Bag', ...
        30, ...
        'Tree', ...
        'Type', 'Classification', ...
        'ClassNames', [0; 1]);

elseif strmatch(type,'fineKNN','exact')
    
    classification = fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Euclidean', ...
    'Exponent', [], ...
    'NumNeighbors', 1, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true, ...
    'ClassNames', [0; 1]);

elseif strmatch(type,'mediumKNN','exact')

    classification = fitcknn(...
        predictors, ...
        response, ...
        'Distance', 'Euclidean', ...
        'Exponent', [], ...
        'NumNeighbors', 10, ...
        'DistanceWeight', 'Equal', ...
        'Standardize', true, ...
        'ClassNames', [0; 1]);

elseif strmatch(type,'coarseKNN','exact')

    classification = fitcknn(...
        predictors, ...
        response, ...
        'Distance', 'Euclidean', ...
        'Exponent', [], ...
        'NumNeighbors', 100, ...
        'DistanceWeight', 'Equal', ...
        'Standardize', true, ...
        'ClassNames', [0; 1]);

elseif strmatch(type,'cubicKNN','exact')

    classification = fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Minkowski', ...
    'Exponent', 3, ...
    'NumNeighbors', 10, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true, ...
    'ClassNames', [0; 1]);

elseif strmatch(type,'cosineKNN','exact')

    classification = fitcknn(...
        predictors, ...
        response, ...
        'Distance', 'Cosine', ...
        'Exponent', [], ...
        'NumNeighbors', 10, ...
        'DistanceWeight', 'Equal', ...
        'Standardize', true, ...
        'ClassNames', [0; 1]);

elseif strmatch(type,'weightedKNN','exact')

    classification = fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Euclidean', ...
    'Exponent', [], ...
    'NumNeighbors', 10, ...
    'DistanceWeight', 'SquaredInverse', ...
    'Standardize', true, ...
    'ClassNames', [0; 1]);

else
    sprintf('Error: The type variable you defined does not match.')
end    
% Create the result struct with predict function
predictorExtractionFcn = @(x) array2table(x, 'VariableNames', headers);
svmPredictFcn = @(x) predict(classification, x);
trainedClassifier.predictFcn = @(x) svmPredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.Classification = classification;
% trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2017a.';
% trainedClassifier.HowToPredict = sprintf('To make predictions on a new predictor column matrix, X, use: \n  yfit = c.predictFcn(X) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nX must contain exactly 3 columns because this model was trained using 3 predictors. \nX must contain only predictor columns in exactly the same order and format as your training \ndata. Do not include the response column or any columns you did not import into the app. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

%% PREDICTING ON TEST SET
% Extract predictors and response
% This code processes the data into the right shape for training the
% model.

% Convert input to table
inputTable = array2table([testingData outcomeTest], 'VariableNames', [headers; 'outcome']);

predictorNames = headers;
predictors = inputTable(:, predictorNames);
response = outcomeTest;


% Compute resubstitution predictions
[validationPredictions, validationScores] = predict(trainedClassifier.Classification, predictors);


% Compute resubstitution accuracy
% validationAccuracy = 1 - resubLoss(trainedClassifier.ClassificationSVM, 'LossFun', 'ClassifError');

end
