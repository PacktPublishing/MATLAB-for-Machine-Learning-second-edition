DataPoints = [100 100;90 90;10 10;10 20;90 70;50 50];
DistanceCalc = pdist(DataPoints);
DistanceMatrix = squareform(DistanceCalc);
GroupsMatrix = linkage(DistanceCalc)
dendrogram(GroupsMatrix)
DistancesCheck = cophenet(GroupsMatrix, DistanceCalc)
NewDistanceCalc = pdist(DataPoints, 'cosine');
NewDistancesCheck = cophenet(NewGroupsMatrix, NewDistanceCalc)
InputData = readmatrix('Minerals.xls');
rng(5);
[IdCluster,Centroid] = kmeans(InputData,4);
gscatter(InputData(:,1), InputData(:,2), IdCluster,'bgrm','x*o^')
hold on
plot(Centroid(:,1),Centroid(:,2),'x','LineWidth',4,'MarkerEdgeColor','k','MarkerSize',25)
silhouette(InputData, IdCluster)
DataKMedoids = readmatrix('PeripheralLocations.xls');
gscatter(DataKMedoids (:,1), DataKMedoids (:,2));
[IdCluster,Kmedoid,SumDist,Dist,IdClKm,info] = kmedoids(DataKMedoids,3);
info
gscatter(DataKMedoids (:,1), DataKMedoids (:,2), IdCluster,'bgr','xo^')
hold on
plot(Kmedoid(:,1),Kmedoid(:,2),'x','LineWidth',4,'MarkerEdgeColor','k','MarkerSize',25)
YHData = readtable('YachtHydrodynamics.xlsx');
size(YHData)
Model1 = stepwiselm(YHData,'constant'  );
Model1
Model2 = stepwiselm(YHData,'linear');
Model2
Model3 = stepwiselm(YHData,'quadratic');
Model3
SeedsData = readtable('SeedsDataset');
plotmatrix(SeedsData{:,1:7})
CorrData=corr(SeedsData{:,1:7})
[coeff,score,latent,tsquared,explained,mu] = pca(SeedsData{:,1:7});
gscatter(score(:,1),score(:,2),SeedsData.Seeds,'brg','xo^')
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',SeedsData.Properties.VariableNames(1:7));
