%**************************************************************************
%Programa para análise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BRNARDES RABLO
%Versão de: 28/12/2020
%**************************************************************************

function [defor,tens] = ALERMEF_EP_RQ4_DeformacoesTensoes(E,nu,a,...
    b,uel,tipoestr)
%0,0 local
x=0; y=0;
B = zeros(3,8);
B(1,1)= -(1/4)*(b-y)/(a*b);
B(1,3)= (1/4)*(b-y)/(a*b);
B(1,5)= (1/4)*(b+y)/(a*b);
B(1,7)= -(1/4)*(b+y)/(a*b);
B(2,2)= -(1/4)*(a-x)/(a*b);
B(2,4)= -(1/4)*(a+x)/(a*b);
B(2,6)= (1/4)*(a+x)/(a*b);
B(2,8)= (1/4)*(a-x)/(a*b);
B(3,1)= -(1/4)*(a-x)/(a*b);
B(3,2)= -(1/4)*(b-y)/(a*b);
B(3,3)= -(1/4)*(a+x)/(a*b);
B(3,4)= (1/4)*(b-y)/(a*b);
B(3,5)= (1/4)*(a+x)/(a*b);
B(3,6)= (1/4)*(b+y)/(a*b);
B(3,7)= (1/4)*(a-x)/(a*b);
B(3,8)= -(1/4)*(b+y)/(a*b);
    if strcmp(tipoestr,'EPD')
        E=E/(1-nu^2);
        nu= nu/(1-nu);
    end
defor = B*uel;
Ee = zeros(3,3);
Ee(1,1)= 1; Ee(1,2)= nu;
Ee(2,1)= nu; Ee(2,2)= 1;
Ee(3,3)= (1-nu)*(1/2);
Ee= (E/(1-nu^2))*Ee;
tens = Ee*defor;
end

