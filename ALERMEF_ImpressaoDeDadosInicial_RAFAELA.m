%**************************************************************************
%Programa para análise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Versão de: 28/12/2020
%**************************************************************************
function ALERMEF_ImpressaoDeDadosInicial_RAFAELA(ida, tipoestr, tipoelem, nglno,...
    npropmat, npropgeo, nnoselem, ncarelem, nnos, nmats, nsecs, nelems, ...
    naps, nelemscar, nnoscar, coordnos, propmats, propgeo, propelems, ...
    restrsap, idcnos, cargasnos, idcelems, cargaselems, ncoord)
%
% Impressão do cabeçalho --------------------------------------------------
fprintf(ida,'***********************************************************');
fprintf(ida,'****************\n');
fprintf(ida,'\nPrograma para Análise de estruturas reticuladas em regime ');
fprintf(ida,'elástico\n\n');
fprintf(ida,'Autor: Rafaela Bernardes Rabelo\n');
fprintf(ida,'Última alteração: Setembro / 2020\n\n');
fprintf(ida,'***********************************************************');
fprintf(ida,'****************\n\n');
%



% Tipo de estrutura -------------------------------------------------------
fprintf(ida,'Tipo de estrutura: ');
switch tipoestr
    case 'TRELICA_PLANA'
        fprintf(ida,'Treliça plana\n');
    case 'PORTICO_PLANO'
        fprintf(ida,'Pórtico plano\n');
    case 'GRELHA'
        fprintf(ida,'Grelha\n');
    case 'TRELICA_ESPACIAL'
        fprintf(ida,'Treliça espacial\n');
    case 'PORTICO_ESPACIAL'
        fprintf(ida,'Portico espacial\n');
end
%
% Tipo de elemento _-------------------------------------------------------
fprintf(ida,'Tipo de elemento: %s\n\n', tipoelem);
%
% Números -----------------------------------------------------------------
fprintf(ida,'Número de nós:                        %i\n', nnos);
fprintf(ida,'Número de materiais:                  %i\n', nmats);
fprintf(ida,'Número de seções transversais:        %i\n', nsecs);
fprintf(ida,'Número de elementos:                  %i\n', nelems);
fprintf(ida,'Número de apoios:                     %i\n', naps);
fprintf(ida,'Número de nós carregados:             %i\n', nnoscar);
fprintf(ida,'Número de propriedades dos materiais: %i\n', npropmat);
fprintf(ida,'Número de propriedades geometricas:   %i\n', npropgeo);
fprintf(ida,'Número de nos dos elementos:          %i\n', nnoselem);
%
if ~strcmp(tipoestr,'TRELICA_PLANA') && ~strcmp(tipoestr,'TRELICA_ESPACIAL')
fprintf(ida,'Número de elementos carregados:       %i\n', nelemscar);
else
end
%
% Coordenadas dos nós -----------------------------------------------------
fprintf(ida,'\nCoordenadas dos nós:\n');
if ncoord==1
    fprintf(ida,'  Nó       X\n');
elseif ncoord==2
    fprintf(ida,'  Nó       X          Y\n');
else
    fprintf(ida,'  Nó       X          Y          Z\n');
end
for i=1:nnos
    fprintf(ida,'%3i', i);
    for j=1:ncoord
        fprintf(ida,'   %8.1f', coordnos(i,j));
    end
    fprintf(ida,'\n');
end
%
% Propriedades dos materiais ----------------------------------------------
fprintf(ida,'\nPropriedades dos materiais:\n');
    if strcmp(tipoestr,'EPT')||strcmp(tipoestr,'EPD')
        fprintf(ida,' Mat         E                Poisson          alfa\n');
    end
    for i=1:nmats
     fprintf(ida,'%3i', i);
        for j=1:npropmat
            fprintf(ida,'    %12.1f', propmats(i,j));
        end
     fprintf(ida,'\n');
    end
%
% Propriedades das seções transversais ------------------------------------
fprintf(ida,'\nPropriedades das seções:\n');
if strcmp(tipoestr,'EPT')||strcmp(tipoestr,'EPD')
  fprintf(ida,' Sec         t\n');
end
for i=1:nsecs
    fprintf(ida,'%3i', i);
    for j=1:npropgeo
        fprintf(ida,'   %10.2f', propgeo(i,j));
    end
    fprintf(ida,'\n');
end
%
% Propriedades dos elementos ----------------------------------------------
fprintf(ida,'\nPropriedades dos elementos:\n');
fprintf(ida,' El   ');
for i=1:nnoselem
    fprintf(ida,'Nó %1i  ',i);
end
fprintf(ida,' Mat   Sec\n');
for i=1:nelems
    fprintf(ida,'%3i', i);
    for j=1:nnoselem+2
        fprintf(ida,'   %3i', propelems(i,j));
    end
    fprintf(ida,'\n');
end
%
% Condições de apoio ------------------------------------------------------
fprintf(ida,'\nCondições de apoio:\n');
if strcmp(tipoestr,'EPT')||strcmp(tipoestr,'EPD')
        fprintf(ida,' Ap    no    rtx   rty\n');
end
for i=1:naps
    fprintf(ida,'%3i', i);
    for j=1:nglno+1
        fprintf(ida,'   %3i', restrsap(i,j));
    end
    fprintf(ida,'\n');
end
%
% Cargas nos elementos ------------------------------------------------------
fprintf(ida,'\nCargas nos elementos:\n');
if nelemscar>0
    if strcmp(tipoestr,'EPT')||strcmp(tipoestr,'EPD')
      fprintf(ida,['  Id   nó   sistema   qx_1     qy_1     qx_2     qy_2    qx_3     qy_3     qx_4     qy_4\n']);
    end
end
for i=1:nelemscar
    fprintf(ida,'%3i   %3i', i, idcelems(i,1));
    if idcelems(i,2)==0
        fprintf(ida,'    local');
    else
        fprintf(ida,'   global');
    end
    for j=1:ncarelem
        fprintf(ida,' %8.3f', cargaselems(i,j));
    end
    fprintf(ida,'\n');
end
%
% Cargas nos nós ----------------------------------------------------------
fprintf(ida,'\nCargas nos nós:\n');
if nnoscar>0
    if strcmp(tipoestr,'EPT')||strcmp(tipoestr,'EPD')
      fprintf(ida,' Id    nó       Fx         Fy\n');;
    end
end
for i=1:nnoscar
    fprintf(ida,'%3i   %3i', i, idcnos(i,1));
    for j=1:nglno
        fprintf(ida,'   %8.3f', cargasnos(i,j));
    end
    fprintf(ida,'\n');
end

end
