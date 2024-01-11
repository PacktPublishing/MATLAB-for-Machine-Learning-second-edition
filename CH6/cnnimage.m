Data = imageDatastore('C:\MatlabScript\PistachioShort', ...
'IncludeSubfolders',true,'LabelSource','foldernames');

figure;
RandId = randperm(2148,9);
for i = 1:9
    subplot(3,3,i);
    imshow(Data.Files{RandId(i)});
end

srcFiles = dir('C:\MatlabScript\PistachioShort\Siirt\*.jpg');  
for i = 1 : length(srcFiles)
filename = strcat('C:\MatlabScript\PistachioShort\Siirt\',srcFiles(i).name);
im = imread(filename);
k=imresize(im,[64 64]);
newfilename=strcat('C:\MatlabScript\PistachioShort\Siirt\',srcFiles(i).name);
imwrite(k,newfilename,'jpg');
end

TrainSamples = 700;
[DataTrain,DataValidation] = splitEachLabel(Data,TrainSamples,'randomize');

layers = [
    imageInputLayer([64, 64, 3])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',50, ...
    'Shuffle','every-epoch', ...
    'ValidationData',DataValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

CNnet = trainNetwork(DataTrain,layers,options);

CNNPredLabel = classify(CNnet,DataValidation);
DataValLabel = DataValidation.Labels;

ACC = sum(CNNPredLabel == DataValLabel)/numel(DataValLabel)
