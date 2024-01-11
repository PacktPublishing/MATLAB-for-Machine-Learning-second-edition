CreditCardData = readtable('CreditCardData.xlsx');
NumOcc = groupcounts(CreditCardData.Class)
boxchart(CreditCardData{:,1:28})
xlabel('features')
ylabel('values')
DataScaled = rescale(CreditCardData{:,1:28},-1,1);
boxchart(DataScaled)
xlabel('features')
ylabel('values')
DataScaled = [DataScaled CreditCardData{:,29}]
n = length(CreditCardData.Class);
SplitData = cvpartition(n,'Holdout',0.3); 
TrainIndex = training(SplitData);
TrainData = DataScaled(TrainIndex,:);
TestIndex = test(SplitData);
TestData = DataScaled(TestIndex,:);
WeightedKNNModel = fitcknn(...
    TrainData(:,1:28), ...
    TrainData(:,29), ...
    'Distance', 'cosine', ...
    'Exponent', [], ...
    'NumNeighbors', 10, ...
    'DistanceWeight', 'SquaredInverse');
PredData = predict(WeightedKNNModel,TestData(:,1:28));
accuracy = sum(PredData == TestData(:,29)) / length(TestData(:,29));
fprintf('Accuracy: %.2f%%\n', accuracy * 100);
