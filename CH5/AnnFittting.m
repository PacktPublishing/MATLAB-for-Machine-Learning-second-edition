load abalone_dataset
[Input,Target] = abalone_dataset;
help abalone_dataset
help nntrain
TFunc = 'trainlm';
HLNodesNum =10;
AbaFitNet = fitnet(HLNodesNum, TFunc);
help nnprocess
AbaFitNet.input.processFcns = {'removeconstantrows','mapminmax'};
AbaFitNet.output.processFcns = {'removeconstantrows','mapminmax'};
AbaFitNet.divideFcn = 'dividerand';  
AbaFitNet.divideMode = 'sample';  
AbaFitNet.divideParam.trainRatio = 70/100;
AbaFitNet.divideParam.valRatio = 15/100;
AbaFitNet.divideParam.testRatio = 15/100;
help nndivision
AbaFitNet.performFcn = 'mse';  
help nnperformance
AbaFitNet.plotFcns = {'plottrainstate','plotperform', 'ploterrhist','plotregression'};
help nnplot
[AbaFitNet,Trs] = train(AbaFitNet,Input,Target);
SimTarget = AbaFitNet(Input);
Diff = gsubtract(Target, SimTarget);
Performance = perform(AbaFitNet, Target, SimTarget)
trainTargets = Target.* Trs.trainMask{1};
valTargets = Target.* Trs.valMask{1};
testTargets = Target.* Trs.testMask{1};
trainPerformance = perform(AbaFitNet,trainTargets, SimTarget)
valPerformance = perform(AbaFitNet,valTargets, SimTarget)
testPerformance = perform(AbaFitNet,testTargets, SimTarget)
view(AbaFitNet)
figure,plotperform(Trs)
figure,plottrainstate(Trs)
figure,ploterrhist(Diff)
figure,plotregression(Target, SimTarget)

