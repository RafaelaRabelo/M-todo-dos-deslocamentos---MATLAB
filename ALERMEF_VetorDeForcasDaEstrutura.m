%**************************************************************************
%Programa para an�lise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Vers�o de: 28/12/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [status, Festr]= ALERMEF_VetorDeForcasDaEstrutura(idat, ...
     tipoelem, nglno, nnoselem, nnoscar, nelemscar, neq, ...
    coordnos, propelems, idcnos, cargasnos, idcelems, cargaselems, glno,...
    propgeo)
%
% Inicailiza��o das vari�veis ---------------------------------------------
status= true;
Festr=zeros(neq,1);nglel= nglno*nnoselem;
fprintf('**** => Vetor de for�as da estrutura.\n');
%
fprintf(idat,'\n********************************\n');
fprintf(idat,'Vetor de for�as da estrutura\n');
fprintf(idat,'********************************\n');
%
% Cargas aplicadas nos n�s ------------------------------------------------
for i=1:nnoscar
    idno= idcnos(i,1);
    for j=1:nglno;
        gl= glno(idno,j);
        if gl>0
            Festr(gl,1)= cargasnos(i,j);
        end
    end
end
% -------------------------------------------------------------------------
for i= 1:nelemscar
    el= idcelems(i,1);
    fprintf(idat,'\nElemento %i:\n',el);
    fprintf(idat,'****************\n');
    % Propriedades do elemento el -----------------------------------------
    idsist=idcelems(i,2); 
    qel=cargaselems(i,:);
    no= propelems(el,1:nnoselem);
    if strcmp(tipoelem,'EP-RQ4')||strcmp(tipoelem,'EP-RQ8')
        [a, b, c,status]= ALERMEF_DimensoesElementoRetangular(el, no, coordnos);
        if status==false
            fprintf('Dimens�o do elemento %i nula ou elemento n�o retangular.\n',el);
            status= false;
            return;
        end
    else
        fprintf('Matriz de rigidez ainda n�o implementada para %s.\n',tipoelem);
        status= false;
        return
    end
    % C�lculo do vetor de for�as equivalentes do elemento no sistema local
    % e da matriz de rota��o ----------------------------------------------
        if  strcmp(tipoelem,'EP-RQ4')
    %TRANSFORMA��O PARA O SISTEMA LOCAL
            if idsist == 1
            fprintf(idat,'Carregamento no Sistema Global: \n');
            fprintf(idat,'Qx_1 = %15.4f    Qy_1 = %15.4f\n',qel(1),qel(2));
            fprintf(idat,'Qx_2 = %15.4f    Qy_2 = %15.4f\n',qel(3),qel(4));
            fprintf(idat,'Qx_3 = %15.4f    Qy_3 = %15.4f\n',qel(5),qel(6));
            fprintf(idat,'Qx_4 = %15.4f    Qy_4 = %15.4f\n',qel(7),qel(8));
            q(1)=qel(1)*c(1)+qel(2)*c(2);
            q(2)=-qel(1)*c(2)+qel(2)*c(1);
            q(3)=qel(3)*c(1)+qel(4)*c(2);
            q(4)=-qel(3)*c(2)+qel(4)*c(1);
            q(5)=qel(5)*c(1)+qel(6)*c(2);
            q(6)=-qel(5)*c(2)+qel(6)*c(1);
            q(7)=qel(7)*c(1)+qel(8)*c(2);
            q(8)=-qel(7)*c(2)+qel(8)*c(1);
            %SISTEMA LOCAL
            fprintf(idat,'Carregamento no Sistema Local: \n');
            fprintf(idat,'qx_1 = %15.4f    qy_1 = %15.4f\n',q(1),q(2));
            fprintf(idat,'qx_2 = %15.4f    qy_2 = %15.4f\n',q(3),q(4));
            fprintf(idat,'qx_3 = %15.4f    qy_3 = %15.4f\n',q(5),q(6));
            fprintf(idat,'qx_4 = %15.4f    qy_4 = %15.4f\n',q(7),q(8));
        else
            fprintf(idat,'Carregamento no Sistema Local:%i\n',idsist);
            for j=1:8
                q(j)=qel(j);
            end
            fprintf(idat,'qx_1 = %15.4f    qy_1 = %15.4f\n',q(1),q(2));
            fprintf(idat,'qx_2 = %15.4f    qy_2 = %15.4f\n',q(3),q(4));
            fprintf(idat,'qx_3 = %15.4f    qy_3 = %15.4f\n',q(5),q(6));
            fprintf(idat,'qx_4 = %15.4f    qy_4 = %15.4f\n',q(7),q(8));
          end
        fprintf(idat,'   %f',q);
        fprintf(idat,'\na = %15.4f\n',a);
        fprintf(idat,'\nb = %15.4f\n',b);
        fprintf(idat,'c(1)= %15.4f    c(2)= %15.4f\n',c(1),c(2));
        %
        feq= ALERMEF_EP_RQ4_CarregamentoEquivalente(q,a,b, propgeo(1));
        Rel= ALERMEF_EP_MatrizDeRotacaoDoElemento(nnoselem,c(1),c(2));
   elseif strcmp(tipoelem,'EP-RQ8')
    %TRANSFORMA��O PARA O SISTEMA LOCAL
        if idsist == 1
        fprintf(idat,'Carregamento no Sistema Global: \n');
        fprintf(idat,'Qx_1 = %15.4f    Qy_1 = %15.4f\n',qel(1),qel(2));
        fprintf(idat,'Qx_2 = %15.4f    Qy_2 = %15.4f\n',qel(3),qel(4));
        fprintf(idat,'Qx_3 = %15.4f    Qy_3 = %15.4f\n',qel(5),qel(6));
        fprintf(idat,'Qx_4 = %15.4f    Qy_4 = %15.4f\n',qel(7),qel(8));
            q(1)=qel(1)*c(1)+qel(2)*c(2);
            q(2)=-qel(1)*c(2)+qel(2)*c(1);
            q(3)=qel(3)*c(1)+qel(4)*c(2);
            q(4)=-qel(3)*c(2)+qel(4)*c(1);
            q(5)=qel(5)*c(1)+qel(6)*c(2);
            q(6)=-qel(5)*c(2)+qel(6)*c(1);
            q(7)=qel(7)*c(1)+qel(8)*c(2);
            q(8)=-qel(7)*c(2)+qel(8)*c(1);
            %SISTEMA LOCAL
        fprintf(idat,'Carregamento no Sistema Local: \n');
        fprintf(idat,'qx_1 = %15.4f    qy_1 = %15.4f\n',q(1),q(2));
        fprintf(idat,'qx_2 = %15.4f    qy_2 = %15.4f\n',q(3),q(4));
        fprintf(idat,'qx_3 = %15.4f    qy_3 = %15.4f\n',q(5),q(6));
        fprintf(idat,'qx_4 = %15.4f    qy_4 = %15.4f\n',q(7),q(8));
        else
        fprintf(idat,'Carregamento no Sistema Local: %i\n',idsist);
            for j=1:8
                q(j)=qel(j);
            end
        fprintf(idat,'qx_1 = %15.4f    qy_1 = %15.4f\n',q(1),q(2));
        fprintf(idat,'qx_2 = %15.4f    qy_2 = %15.4f\n',q(3),q(4));
        fprintf(idat,'qx_3 = %15.4f    qy_3 = %15.4f\n',q(5),q(6));
        fprintf(idat,'qx_4 = %15.4f    qy_4 = %15.4f\n',q(7),q(8));
        end
        fprintf(idat,'   %f',q);
        fprintf(idat,'\na = %10.5f\n',a);
        fprintf(idat,'\nb = %10.5f\n',b);
        fprintf(idat,'c(1)= %f    c(2)= %f\n',c(1),c(2));
        %
        feq= ALERMEF_EP_RQ8_CarregamentoEquivalente(q,a,b, propgeo(1));
        Rel= ALERMEF_EP_MatrizDeRotacaoDoElemento(nnoselem,c(1),c(2));
        else
        status= false;
        return
end
    % Impress�o no arquivo tempor�rio -------------------------------------
    fprintf(idat,'\nVetor de for�as equivalentes do elemento %i (local):\n',el);
        fprintf(idat,'  %12.4f\n',feq);
        fprintf(idat,'\nMatriz de rota��o do elemento %i:\n',el);
    for i=1:nnoselem*nglno
        fprintf(idat,'  %15.4f',Rel(i,:));
        fprintf(idat,'\n');
    end
    fprintf(idat,'\nVetor de for�as do elemento %i (global):\n',el);
    % C�lculo do vetor de for�as do elemento no sistema global ------------
    feq= Rel'*feq;
    % C�lculo dos graus de liberdade do elemento --------------------------
    [gle]= ALERMEF_GrausDeLiberdadeDoElemento(nnoselem,glno,no,nglno);
    % Montagem do vetor de for�as da estrutura --------------------------
    for j=1:nglel
            if gle(j)>0
                Festr(gle(j),1)= Festr(gle(j),1)+feq(j,1);
            end
    end
    % Impress�o no arquivo tempor�rio -------------------------------------
   fprintf(idat,'\nFestr ap�s computar a contribui��o das cargas aplicadas ');
   fprintf(idat,'nos n�s:\n');
   fprintf(idat,'  %15.4f\n',Festr);
    for i=1:nnoselem*nglno
        fprintf(idat,'  %15.4f',feq(i,:));
        fprintf(idat,'\n');
    end
    fprintf(idat,'\nGraus de liberdade do elemento %i:\n',el);
    fprintf(idat,'  %i',gle);
    fprintf(idat,'\n');
    fprintf(idat,'\nVetor de for�as da estrutura ap�s computar a ');
    fprintf(idat,'contribui��o do elemento %i:\n',el);
    for i=1:neq
        fprintf(idat,'  %15.4f\n',Festr(i,1));
    end
end
