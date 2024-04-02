%**************************************************************************
%Programa para análise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Versão de: 28/12/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAU DE LIBERDADE DO ELEMENTO 
function [gle]=ALERMEF_GrausDeLiberdadeDoElemento(nnoselem,glno,no,nglno);
%
V=1;
for i=1:nnoselem;
    for j = 1:nglno;
     gle(1,V)=glno(no(1,i),j);
     V=V+1;
    end
end
%
end
