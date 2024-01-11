Imdbdata = readtable("ImdbDataset.xlsx",'TextType','string');
Imdbdata.Class = categorical(Imdbdata.Class);
figure
histogram(Imdbdata.Class);
xlabel("Class")
ylabel("Frequency")
title("Class Distribution")
DataSplitting = cvpartition(data.Class,'Holdout',0.3);
TrainDataset = Imdbdata(training(DataSplitting),:);
TestDataset = Imdbdata(test(DataSplitting),:);
TrainReview = TrainDataset.Review;
TestReview = TestDataset.Review;
TrainClass = TrainDataset.Class;
TestClass = TestDataset.Class;
TrainDoc = preprocessText(TrainReview);
TestDoc = preprocessText(TestReview);
TrainDoc(1:10)
EncText = wordEncoding(TrainDoc);
NumDoc = doclength(TrainDoc);
figure
histogram(NumDoc)
xlabel("Number of tokens")
ylabel("Number of Reviews")
TokNum = 30;
RewTrain = doc2sequence(EncText,TrainDoc,'Length',TokNum);
RewTest = doc2sequence(EncText,TestDoc,'Length',TokNum);
inputSize = 1;
embeddingDimension = 150;
numHiddenUnits = 50;
numWords = EncText.NumWords;
numClasses = numel(categories(TrainClass));

layers = [ ...
    sequenceInputLayer(inputSize)
    wordEmbeddingLayer(embeddingDimension,numWords)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

options = trainingOptions('adam', ...
    'MiniBatchSize',16, ...
    'GradientThreshold',2, ...
    'Shuffle','every-epoch', ...
    'ValidationData',{RewTest,TestClass}, ...
    'Plots','training-progress', ...
    'Verbose',false);

net = trainNetwork(RewTrain,TrainClass,layers,options);