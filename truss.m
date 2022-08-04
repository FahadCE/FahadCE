%% Calculation
function truss(JC,MJ,JDOF,SDOF,DS,FF)
GDOF= [JDOF(MJ(:,2),:) JDOF(MJ(:,1),:)]
FDOF = setdiff(1:numel(JDOF), SDOF);  % TODO: this will be replaced by an expression later
% define direction cosines
DC=[JC(MJ(:,1),:)-JC(MJ(:,2),:)];
% detemine member lengths
L=sqrt(sum(DC.^2,2))
%% 
%% 
% use member lengths to calculate direction cosines
DC=DC./L

% use DC for member stiffness matrix in global coordinates
K=zeros(numel(JC));

%for I=1:6
for I=1:(length(MJ))
Km=[DC(I,:); DC(I,:)];
Km=Km.*Km';
Km=[Km -Km;-Km Km]/L(I);
K(GDOF(I,:),GDOF(I,:))=K(GDOF(I,:),GDOF(I,:))+Km
end



% Solution
% 1. Displacement at Free DOF, DF
% 2. Support Reactions = Forces at Support DOF, FS

KFF=K(FDOF, FDOF);
KFS=K(FDOF, SDOF);
KSF=K(SDOF, FDOF);
KSS=K(SDOF, SDOF);

DF=inv(KFF)*(FF-KFS*DS)
% DF=KFF\(FF-KFS*DS)
FS=KSS*DS+KSF*DF

D(SDOF,1)=DS
D(FDOF,1)=DF


% Q=[-DC(2,:) DC(2,:)]./L(2)
% Q=Q*[D(GDOF(2,:))]

Q=[-DC DC]./L
Q=Q*[D(GDOF')]
Q=diag(Q)
end