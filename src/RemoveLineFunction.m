function ConnectFinal=RemoveLineFunction(Connection,j)


ConnectFinal = Connection;
ConnectFinal(j,:) = [];

% Dim=size(Connection);
% Dim=Dim(1,1);
% Dim=Dim-1;
% i=1;
% k=1;
% while 1
%     if (i==j)&(k==j)
%     else
%     ConnectFinal(i,1)=Connection(k,1);
%     ConnectFinal(i,2)=Connection(k,2);
%     ConnectFinal(i,3)=Connection(k,3);
%     i=i+1;
%     end 
%     k=k+1;
%     if i>Dim
%         break;
%     end    
% end

end