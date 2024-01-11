[Input,Target] = thyroid_dataset;
trainFcn = 'trainscg'
hiddenLayerSize = 10;
TyroidPatNet = patternnet(hiddenLayerSize, trainFcn);
TyroidPatNet.divideFcn = 'dividerand';  
TyroidPatNet.divideMode = 'sample';  
TyroidPatNet.divideParam.trainRatio = 70/100;
TyroidPatNet.divideParam.valRatio = 15/100;
TyroidPatNet.divideParam.testRatio = 15/100;
TyroidPatNet.performFcn = 'crossentropy';
TyroidPatNet.plotFcns = {'plotperform','plottrainstate','ploterrhist', 'plotconfusion', 'plotroc'};
[TyroidPatNet,Trs] = train(TyroidPatNet,Input,Target);
SimData = TyroidPatNet(Input);
Diff = gsubtract(Target, SimData);
performance = perform(TyroidPatNet, Target, SimData);
TargetInd = vec2ind(Target);
SimDataInd = vec2ind(SimData);
percentErrors = sum(TargetInd ~= SimDataInd)/numel(TargetInd);
trOut = SimData(:,Trs.trainInd);
vOut = SimData (:,Trs.valInd);
tsOut = SimData (:,Trs.testInd);
trTarg = Target(:,Trs.trainInd);
vTarg = Target (:,Trs.valInd);
tsTarg = Target (:,Trs.testInd);
figure, plotconfusion(trTarg, trOut, 'Train', vTarg, vOut, 'Validation', tsTarg, tsOut, 'Testing', Target,SimData,'All')
figure, plotroc(trTarg, trOut, 'Train', vTarg, vOut, 'Validation', tsTarg, tsOut, 'Testing', Target,SimData,'All')