%**************************************************************************
%Programa para análise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Versão de: 28/12/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [status, Kestr]= ALERMEF_MatrizDeRigidezDaEstrutura(idat, ...
      tipoestr,tipoelem, nglno, nnoselem, nelems, neq, coordnos,  ...
      propelems, propmats, propgeo, glno)
 %
 % Inicailização das variáveis ---------------------------------------------
 status= true;
 nglel= nnoselem*nglno;
 Kestr= zeros(neq,neq);      % aqui zeros será trocado por sparse ao final
 fprintf('**** => Matriz de rigidez da estrutura.\n');
 %
 fprintf(idat,'\nMatriz de rigidez da estrutura\n');
 fprintf(idat,'********************************\n');
 % -------------------------------------------------------------------------
 for el=1:nelems
     fprintf(idat,'\nElemento %i:\n',el);
     fprintf(idat,'****************\n');
     % Propriedades do elemento el -----------------------------------------
     idmat= propelems(el,nnoselem+1);
     idsec= propelems(el,nnoselem+2);
     pmat= propmats(idmat,:);
     pgeo= propgeo(idsec,:);
     no= propelems(el,1:nnoselem);
     if strcmp(tipoelem,'EP-RQ4') || strcmp(tipoelem,'EP-RQ8')
        [a, b, c,status]= ALERMEF_DimensoesElementoRetangular(el, no,...
            coordnos);
        if status==false
            fprintf('Dimensão do elemento %i nula ou elemento não retangular.\n',el);
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
         fprintf(idat,'t = %15.4f\n',pgeo(1));
         fprintf(idat,'a = %15.4f    b = %15.4f\n',a,b);
         fprintf(idat,'cs = %15.4f  sn = %15.4f\n',c(1),c(2));
         Kel= ALERMEF_EP_RQ4_MatrizDeRigidezDoElemento(pmat(1),pmat(2),...
             pgeo(1),tipoestr,a,b);
         Rel= ALERMEF_EP_MatrizDeRotacaoDoElemento(nnoselem,c(1), c(2));
     elseif strcmp(tipoelem,'EP-RQ8')
         fprintf(idat,'E = %15.4f\n',pmat(1));
         fprintf(idat,'nu = %15.4f\n',pmat(2));
         fprintf(idat,'t =%15.4f\n',pgeo(1));
         fprintf(idat,'a = %15.4f    b = %15.4f\n',a,b);
         fprintf(idat,'cs = %15.4f  sn = %15.4f\n',c(1),c(2));
         Kel= ALERMEF_EP_RQ8_MatrizDeRigidezDoElemento(pmat(1),pmat(2),...
             pgeo(1),tipoestr,a,b);
         Rel= ALERMEF_EP_MatrizDeRotacaoDoElemento(c(1), c(2),nnoselem);
     else  
        fprintf('Matriz de rigidez do elemento ainda nao implementada para %s e %s.\n', tipoestr, tipoelem);
        fprintf(idat,'Matriz de rigidez do elemento nao implementada para %s e %s.\n', tipoestr, tipoelem);
        status= false;
        return
     end
     % Impressão no arquivo temporário -------------------------------------
     if strcmp(tipoelem,'EP-RQ4')
     fprintf(idat,'\nMatriz de rigidez do elemento %i no sistema local:\n',el);
     for i=1:nglel
         fprintf(idat,'  %15.4f',Kel(i,:));
         fprintf(idat,'\n');
     end
     fprintf(idat,'\nMatriz de rotação do elemento %i:\n',el);
     for i=1:nglel
        fprintf(idat,'  %15.4f',Rel(i,:));
        fprintf(idat,'\n');
     end
     end
     % Cálculo da matriz de rigidez do elemento no sistema global ----------
     if strcmp(tipoelem,'EP-RQ4')
     Kel= Rel'*Kel*Rel;
     end
     % Cálculo dos graus de liberdade do elemento --------------------------
    [gle]=ALERMEF_GrausDeLiberdadeDoElemento(nnoselem,glno,no,nglno);
    
     % Montagem da matriz de rigidez da estrutura --------------------------
   for i=1:nglel;
        if gle(1,i)>0;
            for j=1:nglel;
                if gle(1,j)>0;
                    Kestr(gle(1,i),gle(1,j))= Kestr(gle(1,i),gle(1,j))+Kel(i,j);
                end
            end
        end
   end
     % Impressão no arquivo temporário -------------------------------------
     fprintf(idat,'\nMatriz de rigidez do elemento %i (global):\n',el);
     for i=1:nglel
         fprintf(idat,'  %15.4f',Kel(i,:));
         fprintf(idat,'\n');
     end
     fprintf(idat,'\nGraus de liberdade do elemento %i:\n',el);
     fprintf(idat,'  %i',gle);
     fprintf(idat,'\n');
     fprintf(idat,'\nMatriz de rigidez da estrutura após computar a ');
     fprintf(idat,'contribução do elemento %i:\n',el);
     for i=1:neq
         fprintf(idat,'  %15.4f',Kestr(i,:));
         fprintf(idat,'\n');
     end
 end
%TESTE DE CONSISTENCIA  - DIAGONAL NULA
  for i=1:neq
      if min(Kestr(i,i))<10e-5
           fprintf('Erro de instabilidade estrutural.\n');
           fprintf('Verifique o arquivo de entrada de dados.\n');
           status= false;
           return;
      end
  end
%
end
