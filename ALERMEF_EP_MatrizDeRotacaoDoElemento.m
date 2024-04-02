%**************************************************************************
%Programa para análise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Versão de: 28/12/2020
%**************************************************************************

function Rel = ALERMEF_EP_MatrizDeRotacaoDoElemento(nnoselem,cs,sn)
%
Rel = zeros(2*nnoselem,2*nnoselem);
for i=1:2:2*nnoselem
    Rel(i,i)= cs;
    Rel(i,i+1) = sn;
    Rel(i+1,i) = -sn;
    Rel(i+1,i+1)= cs;
end
%
end

