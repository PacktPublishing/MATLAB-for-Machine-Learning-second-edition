Nile = readtable('Nile.csv');
plot(Nile.time,Nile.Nile)
TimeData = datetime({'01.01.1871';'01.01.1872';'01.01.1873';'01.01.1874';'01.01.1875'});
TempData = [22.1;21.1;23.2;21.9;22.5];
RiverFlow = [1120;1160;963;1210;1160];
NileRiverFlow = timetable(TimeData, TempData, RiverFlow);
class(NileRiverFlow)
NileRiverFlow2 = timetable(RiverFlow,'TimeStep',years(1),'StartTime',years(1870));  
NileRiverFlowData = readtimetable('Nile.csv');
NileRiverFlowData(1:2,:)
NileRiverFlowData.Nile(1:2)
NileData = NileRiverFlowData{:,:};
TimeRange = timerange('01.01.1880','01.01.1920');
DataTimeRange = NileRiverFlowData(TimeRange,:);
WeeklyData = retime(NileRiverFlowData,'weekly','spline');
MonthlyData = retime(NileRiverFlowData,'monthly','mean'  );
windowSize = 5;
SMA = movmean(NileRiverFlowData.Nile,windowSize);
type = 'exponential'
windowSize = 5;
EMA = movavg(NileRiverFlowData.Nile,type,windowSize  )
alpha = 0.3;
forecast = NileRiverFlowData.Nile(1);
for i = 2:length(NileRiverFlowData.Nile)
    forecast(i) = alpha * NileRiverFlowData.Nile (i) + (1 - alpha) * forecast(i - 1);
end
disp(forecast );