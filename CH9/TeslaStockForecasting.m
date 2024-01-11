TeslaData = readtimetable('TSLA.csv');
summary(TeslaData)
plot(TeslaData.Date, TeslaData.Close)
xlabel('Time (years)')
ylabel('Stock price ($)')

PctCh=100*diff(TeslaData.Close(:,1))./TeslaData.Close(1:end-1,1);
bar(TeslaData.Date(1:end-1,1),PctCh)
xlabel('Time (years)') 
ylabel('Percentage changes ($)')
PriceReturn = sum(PctCh);
fprintf('Price Return: %.2f%%\n', PriceReturn);

XData=TeslaData.Close(1:end-1);
YData=TeslaData.Close(2:end);
TrainLength = length(TeslaData.Close)-1;

numHiddenUnits = 200;

layers = [ ...
    sequenceInputLayer(TrainLength)
    lstmLayer(numHiddenUnits,'OutputMode','sequence')
    fullyConnectedLayer(50)
    dropoutLayer(0.5)
    fullyConnectedLayer(TrainLength)
    regressionLayer];
maxEpochs = 600;
miniBatchSize = 20;

options = trainingOptions('adam', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'InitialLearnRate',0.01, ...
    'GradientThreshold',1, ...
    'Shuffle','never', ...
    'Plots','training-progress',...
    'Verbose',0);
net = trainNetwork(XData,YData,layers,options);
YPred = predict(net,XData,'MiniBatchSize',1);
RMSE = sqrt(mean((YData-YPred).^2));
plot(TeslaData.Date(2:end), YData,TeslaData.Date(2:end), YPred,'--')
xlabel('Time (years)')
ylabel('Stock price ($)')
legend('ActualData', 'PredictedData')