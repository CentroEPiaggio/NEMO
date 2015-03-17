%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% [ trainingSet, testSet ] = dataSetSplit(labeledDataSet, percTest)
%
% The labeledDataSet must have the form:
%
% Sensor1 Sensor2 ... SensorN labelIndex
%
% for each class, the last percTest is used as testSet
%
function [ trainingSet, testSet ] = dataSetSplit(labeledDataSet, percTest)

label = labeledDataSet(:,end);

maxLabel = max(label);
minLabel = min(label);

trainingSet = [];
testSet = [];

for i=minLabel:maxLabel
	
	rows = find(label == i);
	
	if(length(rows) > 0)
	
		row_end_training = floor(length(rows)*(100-percTest)*0.01);
		
		if(row_end_training > 0)
		
			rows_training = rows(1:row_end_training);
			trainingSet = [ trainingSet; labeledDataSet(rows_training,:) ];
			
		end
		
		if(row_end_training < length(rows))
		
			rows_test = rows(row_end_training+1:end);
			testSet = [ testSet; labeledDataSet(rows_test,:) ];
			
		end
		
	end
	
end