%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% [ normLabeledDataSet rMin rMax ] = dataSetNormalize(labeledDataSet, vMin, vMax, M)
%
% The labeledDataSet must have the form:
%
% Sensor1 Sensor2 ... SensorN labelIndex1 ... labelIndexM
%
% Only sensors will be normalized using their min and max (also returned by the function)
%
function [ normLabeledDataSet rMin rMax ] = dataSetNormalize(labeledDataSet, vMin, vMax, M)

if(M > 0)
	labels = labeledDataSet(:,end-M+1:end);
	data = labeledDataSet(:,1:end-M);
else
	data = labeledDataSet;
end

rMin = min(data);
rMax = max(data);

data = data - ones(size(data,1), 1)*rMin;  % sottrarre il minimo
data = data*diag(1./(rMax-rMin));          % dividere per la differenza tra max e minimo
data = vMin + data*(vMax - vMin);          % riscalo tra 0.1 ed 0.9

if(M > 0)
	normLabeledDataSet = [data labels];
else
	normLabeledDataSet = data;
end
	
	
