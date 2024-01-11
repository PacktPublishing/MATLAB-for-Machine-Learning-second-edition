UAVData = readtable('DroneFaultDiagnosis.xlsx');
boxplot(UAVData{:,1:31})
xlabel('Features')
ylabel('Leq (dBA)')
n= height(UAVData)
RandSplitInd=randperm(n);
DivNum=round(0.7*n);
TrainData=UAVData(RandSplitInd(1:DivNum),:);
TestData=UAVData(RandSplitInd(DivNum+1:end),:);
SVMModel = fitcsvm(TrainData{:,1:31}, TrainData{:,32}, 'KernelFunction', 'linear', 'BoxConstraint', 1);
PredY = predict(SVMModel, TestData{:,1:31});
accuracy = sum(PredY == TestData{:,32}) / length(PredY);

