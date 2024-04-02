%**************************************************************************
%Programa para an�lise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Vers�o de: 28/12/2020
%**************************************************************************
% LEITURA DE DADOS
function [status, tipoestr, tipoelem, nglno, ncoord,cargaselems,...
    npropmat, npropgeo, nnoselem, ncarelem, nnos, nmats, nsecs, nelems, ...
    naps, nelemscar, nnoscar, coordnos, propmats, propgeo, propelems, ...
    restrsap, idcnos, cargasnos, idcelems]=ALERMEF_Leitura_de_dados_RAFAELA(idae)
%Verifica��o
tipoestr=-1; tipoelem=-1; nglno=-1;
cargaselems=0; npropmat=-1; npropgeo=-1; nnoselem=-1;
ncarelem=-1; nnos=-1; nmats=-1; nsecs=-1; nelems=-1;
naps=-1; nelemscar=-1; nnoscar=-1; coordnos=-1; propmats=0;
propgeo=0; propelems=-1; restrsap=-1; idcnos=-1; cargasnos=-1;idcelems=-1;
%Leitura de dados

fprintf('**** => Entrada de dados.\n');
%
% Cabe�alho inicial -------------------------------------------------------
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
    fprintf('Tipo de estrutura %s n�o implementado.\n', tipoestr);
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
        fprintf('Tipo de elemento n�o implementado ou inconsistente.\n');
        status= false;
    return
 end
%
% N�mero de n�s -----------------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl~=1
    fprintf('Erro na leitura do n�mero de n�s.\n');
    status=false;
    return
end
[nnos,ndl]= fscanf(idae,'%i',1);
if ndl~=1
    fprintf('Erro na leitura do n�mero de n�s.\n');
    status=false;
    return
elseif nnos<nnoselem
    fprintf('N�mero de n�s (%i) inconsistente.\n',nnos);
    status=false;
    return
end
%
% N�mero de materiais -----------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl~=1
    fprintf('Erro na leitura do n�mero de materiais.\n');
    status=false;
    return
end
[nmats,ndl]= fscanf(idae,'%i',1);
if ndl~=1
    fprintf('Erro na leitura do n�mero de materiais.\n');
    status=false;
    return
elseif nmats<1
    fprintf('N�mero de materiais (%i) inconsistente.\n',nmats);
    status=false;
     return
end
%
% N�mero de se��es transversais -------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl~=1
    fprintf('Erro na leitura do n�mero de se��es transversais.\n');
    status=false;
    return
end
[nsecs,ndl]= fscanf(idae,'%i',1);
if ndl~=1
    fprintf('Erro na leitura do n�mero de se��es transversais.\n');
    status=false;
    return
elseif nsecs<1
    fprintf('N�mero de se��es transversais (%i) inconsistente.\n',nsecs);
    status=false;
    return
end
%
% N�mero de elementos -----------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl~=1
    fprintf('Erro na leitura do n�mero de elementos.\n');
    status=false;
    return
end
[nelems,ndl]= fscanf(idae,'%i',1);
if ndl~=1
    fprintf('Erro na leitura do n�mero de elementos.\n');
    status=false;
    return
elseif nelems<nmats
    fprintf('N�mero de elementos (%i) menor do que o n�mero de materiais.\n',nelems);
    status=false;
    return
elseif nelems<nsecs
    fprintf('N�mero de elementos (%i) menor do que o n�mero de se��o transversal.\n',nelems);
    status=false;
    return
elseif nelems<1
    fprintf('N�mero de elementos (%i) inconsistente.\n',nelems);
    status=false;
    return
end
%
% N�mero de apoios --------------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1
    fprintf('Erro na leitura do n�mero de apoios.\n');
    status=false;
    return
end
[naps,ndl]= fscanf(idae,'%i',1);
if ndl~=1
    fprintf('Erro na leitura do n�mero de apoios.\n');
    status=false;
    return
elseif naps<1
    fprintf('N�mero de apoios (%i) inconsistente.\n',naps);
    status=false;
    return
elseif naps>nnos
    fprintf('N�mero de apoios (%i) maior que o n�mero de n�s.\n',naps);
    status=false;
    return
end
%
% N�mero de elementos carregados ------------------------------------------
% SE FOR TRELI�A N�O EXISTE CARGAS APLICADAS NO ELEMENTO
if ~strcmp(tipoestr,'TRELICA_PLANA') && ~strcmp(tipoestr,'TRELICA_ESPACIAL')
    [comentario,ndl]= fscanf(idae,'%s',1);
    if ndl ~=1
        fprintf('Erro na leitura do n�mero de elementos carregados.\n');
        status=false;
        return
    end
    [nelemscar,ndl]= fscanf(idae,'%i',1);
    if ndl~=1
        fprintf('Erro na leitura do n�mero de elementos carregados.\n');
        status=false;
        return
    end
else
    nelemscar = 0;
end
%
% N�mero de n�s carregados ------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1
    fprintf('Erro na leitura do n�mero de n�s carregados.\n');
    status=false;
    return
end
[nnoscar,ndl]= fscanf(idae,'%i',1);
if ndl~=1
    fprintf('Erro na leitura do n�mero de n� carregados.\n');
    status=false;
    return
elseif nnoscar<0
    fprintf('N�mero de n�s carregados (%i) inconsistente.\n',nnoscar);
    status=false;
    return
elseif nnoscar>nnos
    fprintf('N�mero de n�s carregados (%i) inconsistente.\n',nnoscar);
    status=false;
    return
end
%
% Inicializa�ao das matrizes ----------------------------------------------
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
% Coordenadas dos n�s -----------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',2);
for i=1:nnos
    [id,ndl]= fscanf(idae,'%i',1);
    if ndl~=1
        fprintf('Erro na leitura das coordenadas dos n�s.\n');
        status=false;
        return
    elseif id<1 || id>nnos
        fprintf('Erro na leitura das coordenadas dos n�s.\n');
        fprintf('N�mero do n� (%i) inconsistente.\n',id);
        fprintf('Deve estar entre 1 e %i.\n',nnos);
        status=false;
        return
    end
    for j=1:ncoord
        [temp,ndl]= fscanf(idae,'%f',1);
        if ndl~=1
            fprintf('Erro na leitura das coordenadas dos n�s.\n');
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
        fprintf('N�mero do material (%i) inconsistente.\n',id);
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
% Propriedades das se��es transversais ------------------------------------
[comentario,ndl]= fscanf(idae,'%s',2);
for i=1:nsecs
    [id,ndl]= fscanf(idae,'%i',1);
    if ndl~=1
        fprintf('Erro na leitura das se��es transversais.\n');
        status=false;
        return
    elseif id<=0 || id>nsecs
        fprintf('Erro na leitura das se��es transversais.\n');
        status=false;
        return
    end   

end
for j=1:npropgeo
        [temp,ndl]= fscanf(idae,'%f',1);
        if ndl~=1
            fprintf('Erro na leitura das se��es transversais.\n');
           status=false;
            return
        else
            propgeo(id,j)= temp;
        end
if min(min(propgeo))<=0
    fprintf('Propriedades das se��es inconsistentes.\n');
    fprintf('Devem ser valores positivos e n�o nulos.\n');
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
% Condi��es de apoio ------------------------------------------------------
[~,ndl]= fscanf(idae,'%s',1);
if ndl ~=1
    fprintf('Erro na leitura das condi��es de apoio.\n');
    status=false;
    return
end
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1
    fprintf('Erro na leitura das condi��es de apoio.\n');
    status=false;
    return
end
for i=1:naps
    [id,ndl]= fscanf(idae,'%i',1);
    if ndl~=1
        fprintf('Erro na leitura das condi��es de apoio.\n');
        status=false;
        return
    elseif id<=0 || id>naps
        fprintf('Erro na leitura das condi��es de apoio.\n');
        fprintf('N�mero do apoio (%i) inconsistente.\n',id);
        fprintf('Deve estar entre 1 e %i.\n',naps);
        status=false;
        return
    end
    [no,ndl]= fscanf(idae,'%i',1);
    if ndl~=1
        fprintf('Erro na leitura das condi��es de apoio.\n');
        status=false;
        return
    elseif no<=0 || no>nnos
        fprintf('Erro na leitura das condi��es de apoio.\n');
        fprintf('N�mero do n� (%i) inconsistente.\n',id);
        fprintf('Deve estar entre 1 e %i.\n',nnos);
        status=false;
        return
    else
        restrsap(id,1)= no;
    end
    for j=2:nglno+1
        [temp,ndl]= fscanf(idae,'%i',1);
        if ndl~=1
            fprintf('Erro na leitura das condi��es de apoio.\n');
            status=false;
            return
        elseif temp~=0 && temp~=1
            fprintf('Restri��o do n� (%i) inconsistente.\n',no);
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
% Cargas nos n�s ----------------------------------------------------------
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1;
    fprintf('Erro na leitura das cargas nos n�s.\n');
    status=false;
    return
end
[comentario,ndl]= fscanf(idae,'%s',1);
if ndl ~=1;
    fprintf('Erro na leitura das cargas nos n�s.\n');
    status=false;
    return
end
for i=1:nnoscar;
    [id,ndl]= fscanf(idae,'%i',1);
    if ndl~=1;
        fprintf('Erro na leitura das cargas nos n�s.\n');
        status=false;
        return
    elseif id<0 || id>nnoscar;
        fprintf('Erro na leitura das cargas nos n�s.\n');
        fprintf('N�mero da carga (%i) inconsistente.\n',id);
        fprintf('Deve estar entre 0 e %i.\n',nnoscar);
        status=false;
        return
    end
    [no,ndl]= fscanf(idae,'%i',1);
    if ndl~=1;
        fprintf('Erro na leitura das cargas nos n�s.\n');
        status=false;
        return
    elseif no<=0 || no>nnos;
        fprintf('Erro na leitura das cargas nos n�s.\n');
        fprintf('N�mero do n� referente ao caregamento (%i) ',id);
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
            fprintf('Erro na leitura das cargas nos n�s.\n');
            status=false;
            return
        else
            cargasnos(id,j)= temp;
        end
    end
end
status=true;
end
