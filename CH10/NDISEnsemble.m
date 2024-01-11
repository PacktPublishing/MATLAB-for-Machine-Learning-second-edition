NIDSData = readtable('NDISdata.csv');
summary(NIDSData)
n = length(NIDSData.class);
SplitData = cvpartition(n,'Holdout',0.3); 
TrainIndex = training(SplitData);
TrainData = NIDSData(TrainIndex,:);
TestIndex = test(SplitData);
TestData = NIDSData(TestIndex,:);

predictors = TrainData(:,1:41);
response = TrainData.class;

NDISEnsModel = fitcensemble(...
    predictors, ...
    response, ...
    'Method', 'AdaBoostM1');

NDISEnsModel = fitcensemble(TrainData,'class','Method', 'AdaBoostM1');

PredData = predict(NDISEnsModel,TestData(:,1:41));
accuracy = sum(strcmpi(PredData,TestData{:,42})) / height(TestData(:,42));
fprintf('Accuracy: %.2f%%\n', accuracy * 100);