load(‘matrix.mat’) 
data = load(‘matrix.txt’)
NumMatrix = readmatrix(‘NumMatrix.txt’);
NumMatrix = readmatrix(‘NumMatrix.txt’, 'Range', 'A1:C3', 'Delimiter', ',');
TabData = readtable(‘IrisData.csv’);
TabData2 = readtable(‘IrisData.csv’, 'Range', 'A1:C10', 'MissingRule', 'fill');
CellArray = readcell(‘ItalianMuseum.xlsx’);
formatSpec = '%s %d %f %d %d';
fileID = fopen('DataItalianCities.txt', 'r');
DataItalianCities = textscan(fileID, formatSpec);
fclose(fileID)
save MatlabSession.mat
MyMatrix1 = rand(5)
writematrix(MyMatrix1);
writematrix(MyMatrix1,‘ MyMatrix1Del.txt’, 'Delimiter','tab'));
writematrix(MyMatrix1,‘ MyMatrix2.xlsx’)
MyMatrix2 = rand(5)
writematrix(MyMatrix 2,' MyMatrix2.xlsx ','WriteMode','append')
MyTable = table(['A';'B';'C'],[12524 10253;9952 14251;8521 12547],{'Rome';'Naples';'Milan'},[false;true;true])
writetable(MyTable, ' MyTable.csv');
img = imread('coliseum.jpg');
imshow(img);
imwrite(img,'new_coliseum.jpg');
[audio, sampleRate] = audioread('apollo13.wav');
sound(audio,sampleRate)
Apollo13Obj = audioplayer(audio,sampleRate);
play(Apollo13Obj);
audiowrite('apollo13.wav',audio,sampleRate)
InfoAudio = audioinfo('apollo13.wav')
SampleData = readtable('CleaningData.xlsx');
id = {'NA' '' '-19' -19 NaN '.'};
WrongPos = ismissing( SampleData,id);
SampleData(any(WrongPos,2)  ,:)
SampleData = standardizeMissing(SampleData,-19  );
SampleDataNew = fillmissing(SampleData,'previous');
SampleDataMinor = rmmissing(SampleData);
SampleDataOutlier = isoutlier(SampleDataNew(2:end,3:5));
GlassData = readtable('GlassIdentificationDataSet.xlsx');
Max = max(GlassData{:,3:8});
Mean = mean(GlassData{:,3:8});
Min = min(GlassData{:,3:8});
[Max,IndRowMax] = max(GlassData{:,3:8});
Median = median(GlassData{:,3:8});
Mode = mode(GlassData{:,3:8});
Quantile = quantile(GlassData{:,3:8}, [0.25 0.50 0.75]);
Percentiles = prctile(GlassData{:,3:8}, [0.25 0.50 0.75]);
Range = range(GlassData{:,3:8});
Iqr = iqr(GlassData{:,3:8});
Variance = var(GlassData{:,3:8});
StDev = std(GlassData{:,3:8});  
Mad = mad(GlassData{:,3:8});
DataA = rand(4  );
CovarianceMatrix = cov(DataA);
CorrelationMatrix = corrcoef (DataA);
X=1:8
Xnorm=rescale(X)
Xnorm=rescale(X,-1,1)
Data = readtable(‘IrisData.csv’);
summary(Data)
CorrelationMatrix = corrcoef(Data{:,1:4});
imagesc(CorrelationMatrix)
colorbar;  
[CorrelationMatrix, PValues] = corrcoef(Data{:,1:4});
scatter(Data.(1),Data.(2))
scatter(Data.(3),Data.(4))
