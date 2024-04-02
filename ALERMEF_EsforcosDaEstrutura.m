%**************************************************************************
%Programa para análise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Versão de: 28/12/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [status,Esf]= ALERMEF_EsforcosDaEstrutura(idar, idat, nelems, propelems,...
    nnoelem, propmats, propgeo, coordnos, nglno, glno, tipoelem, Uestr,...
    ncarelem, cargaselems,nnoselem,tipoestr,nelemscar,idcelems);
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Inicialização das variáveis ---------------------------------------------
 status= true;
 nglel= nglno*nnoelem;
% Esforços no elementos ---------------------------------------------
 fprintf('**** => Cálculo dos esforços da estrutura.\n');
 fprintf(idat,['\nCálculo dos esforços\n']);
 fprintf(idat,['**********************\n']);
% -------------------------------------------------------------------------
 for el=1:nelems
     Uel= zeros(nglno*nnoselem,1);
     feq= zeros(nglel,1); q= zeros(ncarelem,1); 
     % Propriedades do elemento el -----------------------------------------
     idmat= propelems(el,nnoelem+1);
     idsec= propelems(el,nnoelem+2);
     pmat= propmats(idmat,:);
     psec= propgeo(idsec,:);
     no= propelems(el,1:nnoelem);
     if strcmp(tipoelem,'EP-RQ4') || strcmp(tipoelem,'EP-RQ8')
[a, b, c,status]= ALERMEF_DimensoesElementoRetangular(el, no, coordnos);
        if status==false
            fprintf('Dimensão do elemento %i nula ou elemento não retangular.\n',el);
            status= false;
            return;
        end
     else
        status= false;
        return
     end
     % Cálculo da matriz de rigidez do elemento no sistema local
     % e da matriz de rotação ----------------------------------------------
    if strcmp(tipoelem,'EP-RQ4')
        fprintf(idat,'E = %15.4f\n',pmat(1));
        fprintf(idat,'nu = %15.4f\n',pmat(2));
        fprintf(idat,'t = %15.4f\n',psec(1));
        fprintf(idat,'a = %15.4f\n',a);
        fprintf(idat,'b = %15.4f\n',b);        
        kel= ALERMEF_EP_RQ4_MatrizDeRigidezDoElemento(pmat(1),...
            pmat(2), psec(1), tipoestr,a,b);
        rel= ALERMEF_EP_MatrizDeRotacaoDoElemento(nnoselem,c(1), c(2));
     elseif strcmp(tipoelem,'EP-RQ8')
        fprintf(idat,'E = %15.4f\n',pmat(1));
        fprintf(idat,'nu = %15.4f\n',pmat(2));
        fprintf(idat,'t = %15.4f\n',psec(1));
        fprintf(idat,'a = %15.4f\n',a);
        fprintf(idat,'b = %15.4f\n',b);       
        kel= ALERMEF_EP_RQ8_MatrizDeRigidezDoElemento(pmat(1), ...
            pmat(2), psec(1), tipoestr,a,b);
        rel = ALERMEF_EP_MatrizDeRotacaoDoElemento(nnoselem,c(1),c(2));
     else  
        fprintf(['Matriz de rigidez do elemento ainda nao implementada '],...
            ['para %s e %s.\n'], tipoestr, tipoelem);
        fprintf(idat,['Matriz de rigidez do elemento nao implementada '],...
            ['para %s e %s.\n'], tipoestr, tipoelem);
        status= false;
        return
    end
    
%---------------------------------------------------------------------------        
% Cálculo dos graus de liberdade do elemento --------------------------
    gle=ALERMEF_GrausDeLiberdadeDoElemento(nnoelem,glno,no,nglno);
%---------------------------------------------------------------------------    
% Deslocamentos do elemento no sistema global -------------------------
   for k=1:nglel
        if gle(k)~=0
            Uel(k)= Uestr(gle(k));
        end
    end
% Deslocamentos do elemento no sistema local ----------------------------
   uel = rel*Uel;
% Forças de extremidade com cargas equivalentes -------------------------
   fel=kel*uel;
% Cargas equivalentes dos elementos -------------------------------------
for i= 1:nelemscar
% Vetor de cargas aplicadas no elemento 
        if idcelems(i,1)== el 
        idsist= idcelems(i,2);
        qel= cargaselems(i,1:ncarelem);
        if strcmp(tipoelem,'EP-RQ4')||strcmp(tipoelem,'EP-RQ8')
          %TRANSFORMAÇÃO SISTEMA LOCAL
                if idsist == 1
                fprintf(idat,'Carregamento no Sistema Global: \n');
                fprintf(idat,'Qx_1 = %15.4f    Qy_1 = %15.4f\n',qel(1),qel(2));
                fprintf(idat,'Qx_2 = %15.4f    Qy_2 = %15.4f\n',qel(3),qel(4));                    
                fprintf(idat,'Qx_3 = %15.4f    Qy_3 = %15.4f\n',qel(5),qel(6));
                fprintf(idat,'Qx_4 = %15.4f    Qy_4 = %15.4f\n',qel(7),qel(8));
                q(1)=qel(1)*c(1)+qel(2)*c(2); q(2)=-qel(1)*c(2)+qel(2)*c(1);
                q(3)=qel(3)*c(1)+qel(4)*c(2); q(4)=-qel(3)*c(2)+qel(4)*c(1);
                q(5)=qel(5)*c(1)+qel(6)*c(2); q(6)=-qel(5)*c(2)+qel(6)*c(1);
                q(7)=qel(7)*c(1)+qel(8)*c(2); q(8)=-qel(7)*c(2)+qel(8)*c(1);
                end
                fprintf(idat,'Carregamento no Sistema Local: \n');
                fprintf(idat,'qx_1 = %15.4f    qy_1 = %15.4f\n',q(1),q(2));
                fprintf(idat,'qx_2 = %15.4f    qy_2 = %15.4f\n',q(3),q(4));
                fprintf(idat,'qx_3 = %15.4f    qy_3 = %15.4f\n',q(5),q(6));
                fprintf(idat,'qx_4 = %15.4f    qy_4 = %15.4f\n',q(7),q(8));
            else
                fprintf('Vetor de forças do elemento ainda não implementada ');
                fprintf('para %s e %s.\n', tipoestr, tipoelem);
                status= false;
                return
        end
        end
end
% Forças das extremidades (sem carga eq) -----------------------------------
     fel=fel-feq;
    fprintf(idat,'\nForças de extremidade do elemento %i', el);
    fprintf(idat,' sem cargas equivalentes:\n\n');
    for i=1:nnoselem*nglno
        fprintf(idat,'  %15.4f',fel(i,:));
        fprintf(idat,'\n');
    end
    if strcmp(tipoelem,'EP-RQ4')
        [defor,tens]=ALERMEF_EP_RQ4_DeformacoesTensoes(pmat(1),pmat(2),a, b,uel, tipoestr);
        for i=1:3
            Deformacao(el,i)=defor(i,1);
            Tensoes(el,i)=tens(i,1);
        end
    elseif strcmp(tipoelem,'EP-RQ8')
        [defor,tens]=ALERMEF_EP_RQ8_DeformacoesTensoes(pmat(1),pmat(2),a, b,uel, tipoestr);
        for i=1:3
            Deformacao(el,i)=defor(i,1);
            Tensoes(el,i)=tens(i,1);
        end
    else
        fprintf('\n');
        fprintf('Cálculo dos esforços ainda não implementado para o ');
        fprintf('elemento %s.\n', tipoelem)
        status= false;
        return
    end

%---------------------------------------------------------------------------   
%Impressão dos deslocamentos do elemento no sistema global 

%Impressão dos deslocamentos do elemento no sistema local

%Impressão das forças de extremidade
     if ~strcmp(tipoelem,'TP2')
         fprintf(idat,['\nForças de extremidade do elemento %i com forças '...
         'equivalentes nodais (Fel):\n'],el);
        for i=1:nnoselem*nglno
            fprintf(idat,'  %15.4f',fel(i,:));
            fprintf(idat,'\n');
        end
     else
         fprintf(idat,['\nForças de extremidade do elemento %i '...
         '(fel):\n'],el);
        for i=1:nnoselem*nglno
            fprintf(idat,'  %15.4f',fel(i,:));
            fprintf(idat,'\n');
     end 
     end    

%---------------------------------------------------------------------------  
     if strcmp(tipoelem,'EP-RQ4')
         [defor,tens]=ALERMEF_EP_RQ4_DeformacoesTensoes(pmat(1),pmat(2),a,...
             b,uel, tipoestr);
        for i=1:3
            Deformacao(el,i)=defor(i,1);
            Tensoes(el,i)=tens(i,1);
        end
     elseif strcmp(tipoelem,'EP-RQ8')
          [defor,tens]=ALERMEF_EP_RQ8_DeformacoesTensoes(pmat(1),pmat(2),a,...
             b,uel, tipoestr);
        for i=1:3
            Deformacao(el,i)=defor(i,1);
            Tensoes(el,i)=tens(i,1);
        end
     else
        fprintf('Cálculo dos esforços ainda não implementado para o ');
        fprintf('elemento %s.\n', tipoelem)
        status= false;
        return
     end
 end
%---------------------------------------------------------------------------
ALERMEF_ImpressaoEsforcos(idar, tipoelem, nelems,Deformacao,Tensoes);
ALERMEF_ImpressaoEsforcos(idat, tipoelem, nelems,Deformacao,Tensoes);
status=true;
 end


 function  ALERMEF_ImpressaoEsforcos(ida, tipoelem, nelems, Deformacao,Tensoes);
fprintf(ida,'\n\nEsforços solicitantes da estrutura:\n');
for i=1:nelems
fprintf(ida,'\n--->> No elemento %i:\n',i);
    switch tipoelem
    case 'TP2'
        fprintf(ida,'Nx\n');
    case 'PP2'
        fprintf(ida,'    x     ');
        fprintf(ida,'           Nx            Qy            Mz\n');
    case 'GR2'
        fprintf(ida,'    x     ');
        fprintf(ida,'           Qz            My            Tx\n');
        case 'EP-RQ4'
            nsecoes=1;
        case 'EP-RQ8'
            nsecoes=1;
    end

%IMPRESSÃO DAS TENSÕES E DEFORMAÇÕES
    esp1= blanks(6);
    esp2= blanks(8);    
if  strcmp(tipoelem,'EP-RQ4')||strcmp(tipoelem,'EP-RQ8')
          fprintf(ida,'Deformações: \n' );
          fprintf(ida,'%s  Epsilon x%sEpsilon y%sGama xy\n', esp1,esp2, esp2);
        for j = 1:3
            fprintf(ida,'%18.5d', Deformacao(i,j));
        end
         fprintf(ida,'\n');
         fprintf(ida,'Tensões: \n' );
        fprintf(ida,'%s   Sigma x%sSigma y%sTau xy\n', esp1,esp2,esp2);
        for j = 1:3
            fprintf(ida,'%18.5d', Tensoes(i,j));
        end
         fprintf(ida,'\n');
end
end
 end
 
 

