clear, clc
%% input matrices
% joint coordinates
% JC Convention = [X Y]
JC=[0 0; 0 3; -4 0;-4 3]
% Member Joints
% MJ Convention = [FarJoint NearJoint]
MJ=[ 2 1; 2 3; 4 2]
% Member Cross-section Properties
% Convention = [A E Ix Iy Iz Jx Jy Jz]
% Convention = [A E]
% MCP = [
JDOF=[3 4;1 2;5 6;7 8]
% Member Global DOF (in structure coordinates)
% GDOF Convention = [Nx Ny Fx Fy]
%GDOF=[1 2 6 5;1 2 7 8;1 2 3 4; 3 4 7 8;3 4 6 5;6 5 7 8]
% Support conditions
SDOF = [3 4 5 6 7 8];

% Displacements at supports
DS = [ 0 -0.025 0 0 0 0]';

% Forces on the unrestrained joints


FF=[0 0]';
truss(JC,MJ,JDOF,SDOF,DS,FF)