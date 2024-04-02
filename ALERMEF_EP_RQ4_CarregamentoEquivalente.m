%**************************************************************************
%Programa para análise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Versão de: 28/12/2020
%**************************************************************************

function [fel] = ALERMEF_EP_RQ4_CarregamentoEquivalente(q,a,b,t)
fel = zeros(8,1);
fel(1,1) = a*q(1)+b*q(7);fel(2,1) = a*q(2)+b*q(8);
fel(3,1) = a*q(1)+b*q(3);fel(4,1) = a*q(2)+b*q(4);
fel(5,1) = a*q(5)+b*q(3);fel(6,1) = a*q(6)+b*q(4);
fel(7,1) = a*q(5)+b*q(7);fel(8,1) = a*q(6)+b*q(8);
fel= t*fel;
end

