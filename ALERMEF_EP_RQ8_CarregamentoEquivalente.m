%**************************************************************************
%Programa para análise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Versão de: 28/12/2020
%**************************************************************************

function [fel] = ALERMEF_EP_RQ8_CarregamentoEquivalente(q,a,b,t)
fel= [a * q(1) / 0.3e1 + b * q(7) / 0.3e1 a * q(2) / 0.3e1 + b * q(8) / 0.3e1 a * q(1) / 0.3e1 + b * q(3) / 0.3e1 a * q(2) / 0.3e1 + b * q(4) / 0.3e1 b * q(3) / 0.3e1 + a * q(5) / 0.3e1 b * q(4) / 0.3e1 + a * q(6) / 0.3e1 a * q(5) / 0.3e1 + b * q(7) / 0.3e1 a * q(6) / 0.3e1 + b * q(8) / 0.3e1 0.4e1 / 0.3e1 * a * q(1) 0.4e1 / 0.3e1 * a * q(2) 0.4e1 / 0.3e1 * b * q(3) 0.4e1 / 0.3e1 * b * q(4) 0.4e1 / 0.3e1 * a * q(5) 0.4e1 / 0.3e1 * a * q(6) 0.4e1 / 0.3e1 * b * q(7) 0.4e1 / 0.3e1 * b * q(8)];
fel=transpose(fel); fel= t*fel;
end

