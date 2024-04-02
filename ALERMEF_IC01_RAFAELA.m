%**************************************************************************
%Programa para análise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Versão de: 28/12/2020
%**************************************************************************

%FUNÇÃO DE INICIALIZAÇÃO DO PROGRAMA ALERMEF E ABERTURA DO PROGRAMA DE DADOS
function ALERMEF_IC01_RAFAELA
%
%Inicialização------------------------------------------------
[status, idae, idar, idat]=ALERMEF_Inicializacao();
if status==false
    fprintf('Erro na inicialização do programa.\n');
    return
end
%Leitura de dados
[status, tipoestr, tipoelem, nglno, ncoord,cargaselems,npropmat,...
    npropgeo, nnoselem, ncarelem, nnos, nmats, nsecs, nelems,naps,...
    nelemscar, nnoscar, coordnos, propmats, propgeo, propelems,restrsap,...
    idcnos, cargasnos, idcelems,]=ALERMEF_Leitura_de_dados_RAFAELA(idae);
if status==false
    fprintf('Erro na leitura de dados.\n')
return
end


% Impressão dos dados lidos nos arquivos de saída e temporário ------------
ALERMEF_ImpressaoDeDadosInicial_RAFAELA(idar, tipoestr, tipoelem, nglno,...
    npropmat, npropgeo, nnoselem, ncarelem, nnos, nmats, nsecs, nelems, ...
    naps, nelemscar, nnoscar, coordnos, propmats, propgeo, propelems, ...
    restrsap, idcnos, cargasnos, idcelems, cargaselems, ncoord);
ALERMEF_ImpressaoDeDadosInicial_RAFAELA(idat, tipoestr, tipoelem, nglno,...
    npropmat, npropgeo, nnoselem, ncarelem, nnos, nmats, nsecs, nelems, ...
    naps, nelemscar, nnoscar, coordnos, propmats, propgeo, propelems, ...
    restrsap, idcnos, cargasnos, idcelems, cargaselems, ncoord);

%Graus de liberdade
[glno,neq]=ALERMEF_Grau_de_Liberdade_RAFAELA(tipoestr,nnos,naps,nglno,...
    restrsap,idat);
 if status==false
    fprintf('\nFalha da funcao para calculo do grau de liberdade da ');
    fprintf('estrutura.\n');
    Finalizacao(status);
    return
 end
%Matriz de rigidez da estrutura
[status, Kestr]= ALERMEF_MatrizDeRigidezDaEstrutura(idat, ...
      tipoestr,tipoelem, nglno, nnoselem, nelems, neq, coordnos,  ...
      propelems, propmats, propgeo, glno);
 if status==false;
    fprintf('\nFalha da funcao para calculo da matriz de rigidez da ');
    fprintf('estrutura.\n');
    Finalizacao(status);
    return
 end
%Vetor de cargas da estrutura
[status, Festr]= ALERMEF_VetorDeForcasDaEstrutura(idat, ...
     tipoelem, nglno, nnoselem, nnoscar, nelemscar, neq, ...
    coordnos, propelems, idcnos, cargasnos, idcelems, cargaselems, glno,...
    propgeo);
 if status==false;
    fprintf('\nFalha da funcao para calculo do vetor de cargas da ');
    fprintf('estrutura.\n');
    Finalizacao(status);
    return
 end
%Deslocamentos nodais
[status, Uestr]=ALERMEF_DescolamentosNodais(idar, idat, ...
    tipoestr, nglno, nnos, Kestr, Festr, neq, glno);
 if status==false;
    fprintf('\nFalha da funcao para calculo do vetor de cargas da ');
    fprintf('estrutura.\n');
    Finalizacao(status);
    return
 end
%Esforços 
[status]= ALERMEF_EsforcosDaEstrutura(idar, idat, nelems, propelems,...
    nnoselem, propmats, propgeo, coordnos, nglno, glno, tipoelem, Uestr,...
    ncarelem, cargaselems,nnoselem,tipoestr,nelemscar,idcelems);
 if status==false;
    fprintf('\nFalha da funcao para calculo dos esforços da ');
    fprintf('estrutura.\n');
    Finalizacao(status);
    return
 end
 
%Finalização
Finalizacao(status);
if status==true
    fprintf('Operação realizada com sucesso.\n');
    fprintf('************************************************************\n');
else
    fprintf('Falha na execução do programa.\n');
end
end

%FUNÇÃO DE INICIALIZAÇÃO DO PROGRAMA E ABERTURA DO PROGRAMA DE DADOS
function [status,idae,idar,idat]=ALERMEF_Inicializacao()
idar=-1; idat=-1;
%Controle da command Window
clc
format compact
fprintf('Análise linear de estruturas reticuladas em regime elástico linear por M.E.F.\n');
fprintf('Autora: Rafaela Bernardes Rabelo\n');
fprintf('Versão de: 28/12/2020\n');
fprintf('************************************************************\n');

%Abertura dos arquivos de dados
nome= input('Digite o nome do arquivo de dados (sem terminação):','s');
arq_e= strcat(nome,'.alermef');
idae= fopen(arq_e,'r');
if idae<0
    fprintf('Arquivo de dados %s não encontrado.\n',arq_e)
    fprintf('Execução interrompida.\n');
    status=false;
    return
end
arq_r= strcat(nome,'.res');
idar= fopen(arq_r,'w');
arq_t= strcat(nome,'.prog');
idat= fopen(arq_t,'w');
status=true;
end

%FUNÇÃO PARA FINALIZAÇÃO DO PROGRAMAR ALER
function Finalizacao(status)
if status ==true
    sprintf('Execução bem sucedida\n');
else
    fprintf('Execução interrompida.\n');
end
    fclose('all');
end
