%**************************************************************************
%Programa para análise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Versão de: 28/12/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [status, Festr]= ALERMEF_VetorDeForcasDaEstrutura(idat, ...
     tipoelem, nglno, nnoselem, nnoscar, nelemscar, neq, ...
    coordnos, propelems, idcnos, cargasnos, idcelems, cargaselems, glno,...
    propgeo)
%
% Inicailização das variáveis ---------------------------------------------
status= true;
Festr=zeros(neq,1);nglel= nglno*nnoselem;
fprintf('**** => Vetor de forças da estrutura.\n');
%
fprintf(idat,'\n********************************\n');
fprintf(idat,'Vetor de forças da estrutura\n');
fprintf(idat,'********************************\n');
%
% Cargas aplicadas nos nós ------------------------------------------------
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
            fprintf('Dimensão do elemento %i nula ou elemento não retangular.\n',el);
            status= false;
            return;
        end
    else
        fprintf('Matriz de rigidez ainda não implementada para %s.\n',tipoelem);
        status= false;
        return
    end
    % Cálculo do vetor de forças equivalentes do elemento no sistema local
    % e da matriz de rotação ----------------------------------------------
        if  strcmp(tipoelem,'EP-RQ4')
    %TRANSFORMAÇÃO PARA O SISTEMA LOCAL
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
    %TRANSFORMAÇÃO PARA O SISTEMA LOCAL
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
    % Impressão no arquivo temporário -------------------------------------
    fprintf(idat,'\nVetor de forças equivalentes do elemento %i (local):\n',el);
        fprintf(idat,'  %12.4f\n',feq);
        fprintf(idat,'\nMatriz de rotação do elemento %i:\n',el);
    for i=1:nnoselem*nglno
        fprintf(idat,'  %15.4f',Rel(i,:));
        fprintf(idat,'\n');
    end
    fprintf(idat,'\nVetor de forças do elemento %i (global):\n',el);
    % Cálculo do vetor de forças do elemento no sistema global ------------
    feq= Rel'*feq;
    % Cálculo dos graus de liberdade do elemento --------------------------
    [gle]= ALERMEF_GrausDeLiberdadeDoElemento(nnoselem,glno,no,nglno);
    % Montagem do vetor de forças da estrutura --------------------------
    for j=1:nglel
            if gle(j)>0
                Festr(gle(j),1)= Festr(gle(j),1)+feq(j,1);
            end
    end
    % Impressão no arquivo temporário -------------------------------------
   fprintf(idat,'\nFestr após computar a contribuição das cargas aplicadas ');
   fprintf(idat,'nos nós:\n');
   fprintf(idat,'  %15.4f\n',Festr);
    for i=1:nnoselem*nglno
        fprintf(idat,'  %15.4f',feq(i,:));
        fprintf(idat,'\n');
    end
    fprintf(idat,'\nGraus de liberdade do elemento %i:\n',el);
    fprintf(idat,'  %i',gle);
    fprintf(idat,'\n');
    fprintf(idat,'\nVetor de forças da estrutura após computar a ');
    fprintf(idat,'contribuição do elemento %i:\n',el);
    for i=1:neq
        fprintf(idat,'  %15.4f\n',Festr(i,1));
    end
end
