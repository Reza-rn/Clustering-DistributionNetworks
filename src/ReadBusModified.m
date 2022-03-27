function A = ReadBusModified

% ****************************************************
% * Initialize OpenDSS
% ****************************************************
% Instantiate the OpenDSS Object
DSSObj = actxserver('OpenDSSEngine.DSS');
% Start up the Solver
if ~DSSObj.Start(0),
disp('Unable to start the OpenDSS Engine')
return
end
% Set up the Text, Circuit, and Solution Interfaces
DSSText = DSSObj.Text;
DSSCircuit = DSSObj.ActiveCircuit;
DSSSolution = DSSCircuit.Solution;

% ****************************************************
% * DSSText Object
% ****************************************************
% Load in a circuit
DSSText.Command = 'Compile "C:\Users\re208655\Desktop\NREL_C8\Restoration\Version4_C2\TestNetwork\Master_ALL.dss"';

% Find All Buses
AllBuses = DSSCircuit.AllBusNames;

% Calculate Incmatrix to get All PD Element
DSSText.Command =  'CalcIncMatrix';
IncMatrixCircuit = DSSSolution.IncMatrix;
AllPDElements = DSSSolution.IncMatrixRows;

% Find PD Elements connections
i=1;
k=1;
while i <= size(IncMatrixCircuit,2) - 6
    if IncMatrixCircuit(1,i+2) == 1
        To = AllBuses{IncMatrixCircuit(1, i + 1)+1 , 1};
        In = AllBuses{IncMatrixCircuit(1, i + 4)+1 , 1};
    else
        To = AllBuses{IncMatrixCircuit(1, i + 4)+1 , 1};
        In = AllBuses{IncMatrixCircuit(1, i + 1)+1 , 1};
    end
   A{k,1} = To;
   A{k,2} = In;
   i = i + 6;
   k = k + 1;
end 
    

  %%
  %Wieght of each line
  x=size(A);
  x=x(1,1);
  for i=1:x
     A{i,3}=1; 
  end
  
  

end