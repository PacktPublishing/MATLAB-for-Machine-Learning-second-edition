data = readtable('GearboxAccData.xlsx');
subplot(1,2,1)
boxchart(data.state,data.Vib1)
xlabel('state')
ylabel('Vib1')
subplot(1,2,2)
boxchart(data.state,data.Vib2)
xlabel('state')
ylabel('Vib2')
n = length(data.state);
SplitData = cvpartition(n,'Holdout',0.3); 
TrainIndex = training(SplitData);
TrainData = data(TrainIndex,:);
TestIndex = test(SplitData);
TestData = data(TestIndex,:);

%Logistic Regression
LogRegModel = fitglm(TrainData{:,1:2},TrainData{:,3},'Distribution','binomial','link', 'logit')
PredY = predict(LogRegModel, TestData{:,1:2});
threshold = 0.5;
PredBin = PredY >= threshold;
accuracy = sum(PredBin == TestData{:,3}) / length(TestData{:,3});
fprintf('Accuracy: %.2f%%\n', accuracy * 100);

%Random Forest
numTrees = 100; 
numSamples = size(TrainData, 1);
sampleSize = round(0.6 * numSamples); 

forest = cell(numTrees, 1);  
for i = 1:numTrees
    
    sampleIndices = randi(numSamples, sampleSize, 1);
    X_sample = TrainData{:,1:2}(sampleIndices, :);
    y_sample = TrainData{:,3}(sampleIndices); 
    tree = fitctree(X_sample, y_sample);
    forest{i} = tree;
end
numTestSamples = size(TestData, 1);  
RPredY = zeros(numTestSamples, numTrees);

for i = 1:numTrees
    tree = forest{i};
    RPredY(:, i) = predict(tree, TestData{:,1:2});
end

FinalRPredY = mode(RPredY, 2);
accuracy = sum(FinalRPredY == TestData{:,3}) / length(TestData{:,3});
