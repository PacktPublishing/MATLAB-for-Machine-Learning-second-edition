load fisheriris
tabulate(species)
gplotmatrix(meas, meas  , species);
gscatter(meas(:,3), meas(:,4), species,'rgb','osd');
xlabel('Petal length');
ylabel('Petal width');
ClassTree= fitctree(meas,species);
view(ClassTree)
view(ClassTree,'mode','graph')
predict(ClassTree,meas)
resuberror = resubLoss(ClassTree)
cvrtree = crossval(ClassTree)
cvloss = kfoldLoss(cvrtree)
opts = detectImportOptions('datatraining.txt');
opts.SelectedVariableNames = [3:8];
DataMatrix = readtable('datatraining.txt',opts);
SVMClassifier =  fitcsvm(DataMatrix(:,1:5),DataMatrix(:,6));
SVMClassifier
ResubError = resubLoss(SVMClassifier);
RbfSVMClassifier = fitcsvm(DataMatrix(:,1:5),DataMatrix(:,6),'Standardize',true,'KernelFunction','RBF','KernelScale','auto');
ResubError = resubLoss(RbfSVMClassifier);
VehicleData = readtable('VehiclesItaly.xlsx');
LRModel = fitlm(VehicleData,'Registrations~Population');
disp(LRModel)
EmployeesSalary = readtable('employees.xlsx');
summary(EmployeesSalary)
EmployeesSalary.LevelOfEmployee=categorical(EmployeesSalary.LevelOfEmployee);
class(EmployeesSalary.LevelOfEmployee)
LRModelCat = fitlm(EmployeesSalary,'Salary~YearsExperience*LevelOfEmployee');
Xvalues = linspace(min(EmployeesSalary.YearsExperience),max(EmployeesSalary.YearsExperience));
figure()
gscatter(EmployeesSalary.YearsExperience, EmployeesSalary.Salary, EmployeesSalary.LevelOfEmployee,'bgr','x.o')
title('Salary of  Employees versus Years of the Experience, Grouped by Level of Employee')
line(Xvalues,feval(LRModelCat,Xvalues,'GeneralStaff'),'Color','b','LineWidth',2)
line(Xvalues,feval(LRModelCat,Xvalues,'TechnicalStaff'),'Color','r','LineWidth',2)
line(Xvalues,feval(LRModelCat,Xvalues,'Management'),'Color','g','LineWidth',2)
VehicleData = readtable('VehiclesItaly.xlsx');
LRModel = fitlm(VehicleData,'Registrations~Population');
LRModel.Rsquared
LRModel.MSE
plotResiduals(LRModel)
outliers = find(LRModel.Residuals.Raw < -1.5*10^5)
LRModel2 = fitlm(VehicleData,'Registrations~Population','Exclude',outliers)
LRModel2.Rsquared
