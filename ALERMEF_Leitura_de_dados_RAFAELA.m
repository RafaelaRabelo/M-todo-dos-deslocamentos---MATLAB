%**************************************************************************
%Programa para análise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Versão de: 28/12/2020
%**************************************************************************
% LEITURA DE DADOS
function [status, tipoestr, tipoelem, nglno, ncoord,cargaselems,...
    npropmat, npropgeo, nnoselem, ncarelem, nnos, nmats, nsecs, nelems, ...
    naps, nelemscar, nnoscar, coordnos, propmats, propgeo, propelems, ...
    restrsap, idcnos, cargasnos, idcelems]=ALERMEF_Leitura_de_dados_RAFAELA(idae)
%Verificação
tipoestr=-1; tipoelem=-1; nglno=-1;
cargaselems=0; npropmat=-1; npropgeo=-1; nnoselem=-1;
ncarelem=-1; nnos=-1; nmats=-1; nsecs=-1; nelems=-1;
naps=-1; nelemscar=-1; nnoscar=-1; coordnos=-1; propmats=0;
propgeo=0; propelems=-1; restrsap=-1; idcnos=-1; cargasnos=-1;idcelems=-1;
%Leitura de dados

fprintf('**** => Entrada de dados.\n');
%
% Cabeçalho inicial -------------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
%
% Tipo de estrutura -------------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl~=1
    fprintf('Erro na leitura do tipo de estrutura.\n');
    status=false;
    return
end
[tipoestr,ndl]= fscanf(idae,'%s',1);
if ndl~=1
    fprintf('Erro na leitura do tipo de estrutura.\n');
    status=false;
    return
end
tipoestr= upper(tipoestr);
if strcmp(tipoestr,'EPT') || strcmp(tipoestr,'EPD')
    nglno= 2;
    ncoord= 2;
    npropmat= 3;
    npropgeo= 1;
else
    fprintf('Tipo de estrutura %s não implementado.\n', tipoestr);
    fprintf('Tipos implementados:\n');
    fprintf('EPT\nEPD\n');
    status=false;
    return
end
%
% Tipo de elemento _-------------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl~=1
    fprintf('Erro na leitura do tipo de elemento.\n');
    status=false;
    return
end
[tipoelem,ndl]= fscanf(idae,'%s',1);
if ndl~=1
    fprintf('Erro na leitura do tipo de elemento.\n');
    status=false;
    return
else
    tipoelem= upper(tipoelem);
end
 if strcmp(tipoestr,'EPT') || strcmp(tipoestr,'EPD')
        if strcmp(tipoelem,'EP-RQ4')
            nnoselem= 4;
            ncarelem= 8;
        elseif strcmp(tipoelem,'EP-RQ8')
            nnoselem= 8;
            ncarelem= 8;
        else
            fprintf('Elemento inconsistente com o tipo de estrutura.\n');
            fprintf('Tipos consistentes:\n');
            fprintf('EP_RQ4, EP-RQ8\n');
            status=false;
            return
        end
 else
        fprintf('Tipo de elemento não implementado ou inconsistente.\n');
        status= false;
    return
 end
%
% Número de nós -----------------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl~=1
    fprintf('Erro na leitura do número de nós.\n');
    status=false;
    return
end
[nnos,ndl]= fscanf(idae,'%i',1);
if ndl~=1
    fprintf('Erro na leitura do número de nós.\n');
    status=false;
    return
elseif nnos<nnoselem
    fprintf('Número de nós (%i) inconsistente.\n',nnos);
    status=false;
    return
end
%
% Número de materiais -----------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl~=1
    fprintf('Erro na leitura do número de materiais.\n');
    status=false;
    return
end
[nmats,ndl]= fscanf(idae,'%i',1);
if ndl~=1
    fprintf('Erro na leitura do número de materiais.\n');
    status=false;
    return
elseif nmats<1
    fprintf('Número de materiais (%i) inconsistente.\n',nmats);
    status=false;
     return
end
%
% Número de seções transversais -------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl~=1
    fprintf('Erro na leitura do número de seções transversais.\n');
    status=false;
    return
end
[nsecs,ndl]= fscanf(idae,'%i',1);
if ndl~=1
    fprintf('Erro na leitura do número de seções transversais.\n');
    status=false;
    return
elseif nsecs<1
    fprintf('Número de seções transversais (%i) inconsistente.\n',nsecs);
    status=false;
    return
end
%
% Número de elementos -----------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl~=1
    fprintf('Erro na leitura do número de elementos.\n');
    status=false;
    return
end
[nelems,ndl]= fscanf(idae,'%i',1);
if ndl~=1
    fprintf('Erro na leitura do número de elementos.\n');
    status=false;
    return
elseif nelems<nmats
    fprintf('Número de elementos (%i) menor do que o número de materiais.\n',nelems);
    status=false;
    return
elseif nelems<nsecs
    fprintf('Número de elementos (%i) menor do que o número de seção transversal.\n',nelems);
    status=false;
    return
elseif nelems<1
    fprintf('Número de elementos (%i) inconsistente.\n',nelems);
    status=false;
    return
end
%
% Número de apoios --------------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1
    fprintf('Erro na leitura do número de apoios.\n');
    status=false;
    return
end
[naps,ndl]= fscanf(idae,'%i',1);
if ndl~=1
    fprintf('Erro na leitura do número de apoios.\n');
    status=false;
    return
elseif naps<1
    fprintf('Número de apoios (%i) inconsistente.\n',naps);
    status=false;
    return
elseif naps>nnos
    fprintf('Número de apoios (%i) maior que o número de nós.\n',naps);
    status=false;
    return
end
%
% Número de elementos carregados ------------------------------------------
% SE FOR TRELIÇA NÃO EXISTE CARGAS APLICADAS NO ELEMENTO
if ~strcmp(tipoestr,'TRELICA_PLANA') && ~strcmp(tipoestr,'TRELICA_ESPACIAL')
    [comentario,ndl]= fscanf(idae,'%s',1);
    if ndl ~=1
        fprintf('Erro na leitura do número de elementos carregados.\n');
        status=false;
        return
    end
    [nelemscar,ndl]= fscanf(idae,'%i',1);
    if ndl~=1
        fprintf('Erro na leitura do número de elementos carregados.\n');
        status=false;
        return
    end
else
    nelemscar = 0;
end
%
% Número de nós carregados ------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1
    fprintf('Erro na leitura do número de nós carregados.\n');
    status=false;
    return
end
[nnoscar,ndl]= fscanf(idae,'%i',1);
if ndl~=1
    fprintf('Erro na leitura do número de nó carregados.\n');
    status=false;
    return
elseif nnoscar<0
    fprintf('Número de nós carregados (%i) inconsistente.\n',nnoscar);
    status=false;
    return
elseif nnoscar>nnos
    fprintf('Número de nós carregados (%i) inconsistente.\n',nnoscar);
    status=false;
    return
end
%
% Inicializaçao das matrizes ----------------------------------------------
coordnos= zeros(nnos,ncoord);
propmats= zeros(nmats,npropmat);
propgeo= zeros(nsecs,npropgeo);
propelems= zeros(nelems,nnoselem+2);
restrsap= zeros(naps,nglno+1);
idcelems= zeros(nelemscar,2);
cargaselems= zeros(nelemscar,ncarelem);
idcnos= zeros(nnoscar,1);
cargasnos= zeros(nnoscar,nglno);
%
% Coordenadas dos nós -----------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',2);
for i=1:nnos
    [id,ndl]= fscanf(idae,'%i',1);
    if ndl~=1
        fprintf('Erro na leitura das coordenadas dos nós.\n');
        status=false;
        return
    elseif id<1 || id>nnos
        fprintf('Erro na leitura das coordenadas dos nós.\n');
        fprintf('Número do nó (%i) inconsistente.\n',id);
        fprintf('Deve estar entre 1 e %i.\n',nnos);
        status=false;
        return
    end
    for j=1:ncoord
        [temp,ndl]= fscanf(idae,'%f',1);
        if ndl~=1
            fprintf('Erro na leitura das coordenadas dos nós.\n');
            status=false;
            return
        else
            coordnos(id,j)= temp;
        end
    end
end
%
% Propriedades dos materiais ----------------------------------------------
comentario= fscanf(idae,'%s',2);
for i=1:nmats
    [id,ndl]= fscanf(idae,'%i',1);
    if ndl~=1
        fprintf('Erro na leitura das propriedades dos materiais.\n');
        status= false;
        return
    elseif id<1 || id>nmats
        fprintf('Erro na leitura das propriedades dos materiais.\n');
        fprintf('Número do material (%i) inconsistente.\n',id);
        fprintf('Deve estar entre 1 e %i.\n',nmats);
        status= false;
        return
    end
    for j=1:npropmat
        [temp,ndl]= fscanf(idae,'%f',1);
        if ndl~=1
            fprintf('Erro na leitura das propriedades dos materiais.\n');
            status= false;
            return
        else
            propmats(id,j)= temp;
        end
    end
end
% Propriedades das seções transversais ------------------------------------
[comentario,ndl]= fscanf(idae,'%s',2);
for i=1:nsecs
    [id,ndl]= fscanf(idae,'%i',1);
    if ndl~=1
        fprintf('Erro na leitura das seções transversais.\n');
        status=false;
        return
    elseif id<=0 || id>nsecs
        fprintf('Erro na leitura das seções transversais.\n');
        status=false;
        return
    end   

end
for j=1:npropgeo
        [temp,ndl]= fscanf(idae,'%f',1);
        if ndl~=1
            fprintf('Erro na leitura das seções transversais.\n');
           status=false;
            return
        else
            propgeo(id,j)= temp;
        end
if min(min(propgeo))<=0
    fprintf('Propriedades das seções inconsistentes.\n');
    fprintf('Devem ser valores positivos e não nulos.\n');
    status= false;
    return
end
%
% Propriedades dos elementos ----------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1;
    fprintf('Erro na leitura da entrada de dados.\n');
    status=false;
    return
end
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1;
    fprintf('Erro na leitura da entrada de dados.\n');
    status=false;
    return
end
for i=1:nelems;
    [id,ndl]= fscanf(idae,'%i',1);
    if ndl~=1;
        fprintf('Erro na leitura das propriedades dos elementos.\n')
        status=false;
        return
    elseif id<=0 || id>nelems;
        fprintf('Erro na leitura das propriedades dos elementos.\n');
        status=false;
        return
    end
    for j=1:(nnoselem+2)
        [temp,ndl]= fscanf(idae,'%f',1);
        if ndl~=1;
            fprintf('Erro na leitura das propriedades dos elementos.\n');
            status=false;
            return
        else
            propelems(id,j)= temp;
        end
    end
end
%
% Condições de apoio ------------------------------------------------------
[~,ndl]= fscanf(idae,'%s',1);
if ndl ~=1
    fprintf('Erro na leitura das condições de apoio.\n');
    status=false;
    return
end
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1
    fprintf('Erro na leitura das condições de apoio.\n');
    status=false;
    return
end
for i=1:naps
    [id,ndl]= fscanf(idae,'%i',1);
    if ndl~=1
        fprintf('Erro na leitura das condições de apoio.\n');
        status=false;
        return
    elseif id<=0 || id>naps
        fprintf('Erro na leitura das condições de apoio.\n');
        fprintf('Número do apoio (%i) inconsistente.\n',id);
        fprintf('Deve estar entre 1 e %i.\n',naps);
        status=false;
        return
    end
    [no,ndl]= fscanf(idae,'%i',1);
    if ndl~=1
        fprintf('Erro na leitura das condições de apoio.\n');
        status=false;
        return
    elseif no<=0 || no>nnos
        fprintf('Erro na leitura das condições de apoio.\n');
        fprintf('Número do nó (%i) inconsistente.\n',id);
        fprintf('Deve estar entre 1 e %i.\n',nnos);
        status=false;
        return
    else
        restrsap(id,1)= no;
    end
    for j=2:nglno+1
        [temp,ndl]= fscanf(idae,'%i',1);
        if ndl~=1
            fprintf('Erro na leitura das condições de apoio.\n');
            status=false;
            return
        elseif temp~=0 && temp~=1
            fprintf('Restrição do nó (%i) inconsistente.\n',no);
            fprintf('Deve ser 0 (livre) ou 1 (restrito).\n');
            status=false;
            return
        else
            restrsap(id,j)= temp;
        end 
    end
end
%
% Cargas nos elementos ------------------------------------------------------
if ~strcmp(tipoestr,'TRELICA_PLANA') && ~strcmp(tipoestr,'TRELICA_ESPACIAL')
    [comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1;
    fprintf('Erro na leitura das cargas nos elementos.\n');
    status=false;
    return
end
    [comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1
    fprintf('Erro na leitura das cargas nos elementos.\n');
    status=false;
    return
end
    for i=1:nelemscar;
    [id,ndl]= fscanf(idae,'%i',1);
        if ndl ~=1
           fprintf('Erro na leitura das cargas dos elementos.\n');
           status=false;
           return
        elseif id>nelemscar;
           fprintf('Carga (%i) no elemento inconsistente.\n',id);
           fprintf('O indicador de carga deve estar entre 1 e %i.\n',...
                nelemscar);
           status=false;
           return
        end
    for j=1:2;
        [temp,ndl]=fscanf(idae,'%i',1);
        if ndl ~=1
           fprintf('Erro na leitura das cargas dos elementos.\n');
           status=false;
           return
        end
        idcelems(id,j)=temp;
    end
    for j=1:ncarelem;
        [temp,ndl]=fscanf(idae,'%f',1);
        if ndl ~=1
        fprintf('Erro na leitura das cargas dos elementos.\n');
        status=false;
            return
        end
        cargaselems(id,j)=temp;
    end
end
if min(idcelems(:,1))<1 || max (idcelems(:,1)) > nelems;
    fprintf('Algum elemento carregado inconsistente.\n')
    fprintf('O elemento carregado deve estar entre 1 e %1.\n', nelems);
    status=false;
    return
end
if min(idcelems(:,2))<0 || max (idcelems(:,2)) > 1;
    fprintf(['Algum indicador do sistema de eixos do ',...
        'carregamento inconsistente.\n'])
    fprintf(['O indicador do sistema de eixos do carregamento deve ser', ...
    ' 0 (sistema local) ou 1 (sistema global).\n']);
    status=false;
    return
end
else
    idcelems=0;
    cargaselems=0;
end
%
% Cargas nos nós ----------------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1;
    fprintf('Erro na leitura das cargas nos nós.\n');
    status=false;
    return
end
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1;
    fprintf('Erro na leitura das cargas nos nós.\n');
    status=false;
    return
end
for i=1:nnoscar;
    [id,ndl]= fscanf(idae,'%i',1);
    if ndl~=1;
        fprintf('Erro na leitura das cargas nos nós.\n');
        status=false;
        return
    elseif id<0 || id>nnoscar;
        fprintf('Erro na leitura das cargas nos nós.\n');
        fprintf('Número da carga (%i) inconsistente.\n',id);
        fprintf('Deve estar entre 0 e %i.\n',nnoscar);
        status=false;
        return
    end
    [no,ndl]= fscanf(idae,'%i',1);
    if ndl~=1;
        fprintf('Erro na leitura das cargas nos nós.\n');
        status=false;
        return
    elseif no<=0 || no>nnos;
        fprintf('Erro na leitura das cargas nos nós.\n');
        fprintf('Número do nó referente ao caregamento (%i) ',id);
        fprintf('inconsistente.\n');
        fprintf('Deve estar entre 1 e %i.\n',nnos);
        status=false;
        return
    else
        idcnos(id,1)= no;
    end
    for j=1:nglno;
        [temp,ndl]= fscanf(idae,'%f',1);
        if ndl~=1;
            fprintf('Erro na leitura das cargas nos nós.\n');
            status=false;
            return
        else
            cargasnos(id,j)= temp;
        end
    end
end
status=true;
end
