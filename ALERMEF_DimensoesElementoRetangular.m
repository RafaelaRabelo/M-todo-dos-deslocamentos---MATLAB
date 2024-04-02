%**************************************************************************
%Programa para análise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Versão de: 28/12/2020
%**************************************************************************

function [a, b, c,status]= ALERMEF_DimensoesElementoRetangular(el, no, ...
    coordnos)
status=true;
%dimensões do elemento retangular
c= zeros(2,2);
dx= coordnos(no(2),1) - coordnos(no(1),1);dy=coordnos(no(2),2) - coordnos(no(1),2);
a = sqrt(dx^2+dy^2)/2;
dx_2= coordnos(no(3),1) - coordnos(no(2),1);dy_2=coordnos(no(3),2) - coordnos(no(2),2);
b = sqrt(dx_2^2+dy_2^2)/2;
dx_3= coordnos(no(3),1) - coordnos(no(4),1);dy_3=coordnos(no(3),2) - coordnos(no(4),2);
a_2 = sqrt(dx_3^2+dy_3^2)/2;
dx_4= coordnos(no(1),1) - coordnos(no(4),1);dy_4=coordnos(no(1),2) - coordnos(no(4),2);
b_2 = sqrt(dx_4^2+dy_4^2)/2;
%teste
if a <= 10e-8*(max(max(coordnos))-min(min(coordnos))) || b <= 10e-8*(max(max(coordnos))-min(min(coordnos)))
    fprintf('Comprimento do elemento %i nulo.\n',el);
    status= false;
    return;
end
if abs(a-a_2)>= 10e-8 || abs(b-b_2)>= 10e-8
    fprintf('Elemento %i não retangular.\n',el);
    status= false;
    return;
end
c(1)= dx/(2*a); c(2)= dy/(2*a);
end

