load('./dataset.txt');    %matrice dei dati

featuresIndex = 1:10;    %prime 10 variabili

dataSet = [ dataset(:,featuresIndex) dataset(:,end) ];   %una parte per l-analisi, l-atltro eliminato

[getSet, skipSet] = dataSetSplit(dataSet, 98);

dataSet = getSet;

[dataSet vMin vMax ] = dataSetNormalize(dataSet, 0.1, 0.9,1);     %scalato tra 0.1 e 0.9

[trainingSet, testSet] = dataSetSplit(dataSet, 20);     %servono entrambi, quindi vengono splittati

trainingEpochs = 500;


pca(trainingSet, 0.9);   %richiamo PCA. In in dati e 0.9, contenuto di informazione che voglio (percentuale)