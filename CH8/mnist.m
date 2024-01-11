FolderPath = fullfile(toolboxdir('nnet'),'nndemos','nndatasets','DigitDataset');
DigitData = imageDatastore(FolderPath, 'IncludeSubfolders',true,'LabelSource','foldernames');
figure;
RandId = randperm(10000,9);
for i = 1:9
    subplot(3,3,i);
    imshow(DigitData.Files{RandId(i)});
end
ClassDist = countEachLabel(DigitData)
SplitRate = 0.7;
[TrainDat,ValDat] = splitEachLabel(DigitData,SplitRate,'randomize');


layers = [
    imageInputLayer([28, 28, 1])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(1,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',50, ...
    'Shuffle','every-epoch', ...
    'ValidationData',ValDat, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

CNnet = trainNetwork(TrainDat,layers,options);