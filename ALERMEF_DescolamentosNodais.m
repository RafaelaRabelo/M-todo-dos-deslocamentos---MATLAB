%**************************************************************************
%Programa para análise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Versão de: 28/12/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Função para leitura de dados
function [status, Uestr]=ALERMEF_DescolamentosNodais(idar, idat, ...
    tipoestr, nglno, nnos, Kestr, Festr, neq, glno);

%CÁLCULO DOS DESLOCAMENTOS LIVRES
Uestr=zeros(neq,1);
Uestr=Kestr\Festr;
%DESLOCAMENTO DA ESTRUTURA
Uestrl=zeros(nglno*nnos,1);
for i=1:nnos
    for j=1:nglno
        if glno(i,j)~=0
            Uestrl(j+nglno*(i-1))=Uestr(glno(i,j));
        end
    end
end
%
% Impressão dos deslocamentos nodais------------
ALERMEF_ImpressaoDeDescolacamentosNodais(idar, Uestrl, nglno,tipoestr, nnos);
ALERMEF_ImpressaoDeDescolacamentosNodais(idat, Uestrl, nglno,tipoestr, nnos);

status=true;
end


%Função para impressão inicial dos dados lidos
function ALERMEF_ImpressaoDeDescolacamentosNodais(ida, Uestr1, nglno,...
    tipoestr, nnos);
%Impressão dos deslocamentos nodais
fprintf(ida,'\nDeslocamentos Nodais:\n');
if strcmp(tipoestr,'EPT')||strcmp(tipoestr,'EPD')
  fprintf(ida,'Nó      Ux         Uy\n');
end
for i=1:nnos
    fprintf(ida,'%3i', i);
    for j=1:nglno
        fprintf(ida,' %20.4e', Uestr1(j+nglno*(i-1)));
    end
    fprintf(ida,'\n');
end
end
