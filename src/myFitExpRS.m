%
% [xFit yFit yError y0 A lambda x0 sFormula] = myFitExpRS(xData, yData, resamplingCount, sFormulaMode);
%
% [ABSTRACT]
% data FITting using EXPonential Raising Saturated model: y0 + A * ( 1 - exp(-lambda*(x-x0)))
%
% [INPUT]
% xData: row vector: input x data
% yData: row vector: input y data
% resamplingCount: integer: the number of the new xFit elements
% sFormulaMode: string: 'tex', 'latex', 'none'
%	
% [OUTPUT]
% xFit: row vector: output x data (#resamplingCount samples)
% yFit: row vector: output y data (#resamplingCount samples)
% yError: real: average of the sum of the squared errors
% y0, A, lambda, x0: real: fitting coefficients	of the model
% sFormula: string: formatted text of the model
%
% marcello.ferro@ing.unipi.it
%
function [xFit yFit yError y0 A lambda x0 sFormula] = myFitExpRS(xData, yData, resamplingCount, sFormulaMode);

%
% To do: define the number of the parameters to be estimated.
%
estimatesCount = 2;

% do not edit
x0 = min(xData);
y0 = min(yData);
start_point = rand(1, estimatesCount);
model = @myModel;

%
% To do: dispatch params to the formula model. Maybe some of them are global variables.
%
estimates = fminsearch(model, start_point);
A = estimates(1);
lambda = estimates(2);
dispParams = [y0 A lambda x0];

% do not edit
xFit = x0+(0:resamplingCount)*(max(xData)-x0)/resamplingCount;
yFit = myFormula(xFit, dispParams);
yDataFit = myFormula(xData, dispParams);
sFormula = myFormulaString(sFormulaMode, dispParams);

%
% To do: avoid division by zero!
%
yError = sum(((yDataFit - yData)./yData).^2)/length(xData);

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%
	% myModel:
	%
	function [sse] = myModel(params)
		%
		% To do: dispatch params to the formula model. Maybe some of them are global variables.
		%
		dispParams = [y0 params(1) params(2) x0];
		
		% do not edit
		fittedCurve = myFormula(xData, dispParams);
		errorVector = fittedCurve - yData;
		sse = sum(errorVector .^ 2);
	end


	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%
	% myFormula:
	%
	function [yValues] = myFormula(xValues, params)
		%
		% To do: define our formula model for data fitting.
		%
		yValues = params(1) + params(2) * (1-exp(-params(3)*(xValues-params(4))));
	end
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%
	% myFormulaString:
	%
	function [sFormula] = myFormulaString(sFormulaMode, params)
		%
		% To do: define our formula model for data fitting.
		%
		switch(sFormulaMode)
		case 'tex'
			sFormula = sprintf('%.04f + %.04f \\cdot [ 1 - e^{(x - %.04f) / %.04f} ]', params(1), params(2), params(4), 1/params(3));
		case 'latex'
			sFormula = sprintf('%.04f + %.04f \\cdot [ 1 - e^{\\frac{x-%.04f}{%.04f} ]', params(1), params(2), params(4), 1/params(3));
		case 'none'
			sFormula = sprintf('%.04f + %.04f * \\{1 - exp[(x - %.04f) / %.04f]\\}', params(1), params(2), params(4), 1/params(3));
		end
	end
	
end

