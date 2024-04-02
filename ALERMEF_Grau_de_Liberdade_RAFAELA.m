%**************************************************************************
%Programa para an�lise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Vers�o de: 28/12/2020
%**************************************************************************
% GRAU DE LIBERDADE
function [glno,neq]=ALERMEF_Grau_de_Liberdade_RAFAELA(tipoestr,nnos,naps,nglno,...
    restrsap,idat);

glno=zeros(nnos,nglno);
for i=1:naps
    no=restrsap(i,1);
    for j=2:nglno+1
        glno(no,j-1)=restrsap(i,j);
    end
end

neq=0;
for i=1:nnos
    for j=1:nglno
        if glno(i,j)==1
           glno(i,j)=0;
        else neq=neq+1;
            glno(i,j)=neq;
        end
    end
end

%Impress�o do n�mero de equa��es (neq)
%
fprintf(idat,'\n N�mero de equa��es (neq):');
fprintf(idat,'    %i \n', neq);

%Impress�o dos Graus de Liberdade da estrutura
%
fprintf(idat,'\n Graus de Liberdade da estrutura:\n');
fprintf(idat,'***************************************\n');

for i=1:nnos
    for j=1:nglno
        fprintf(idat,'%3i   ', glno(i,j));
    end
    fprintf(idat,'\n');
end

end
