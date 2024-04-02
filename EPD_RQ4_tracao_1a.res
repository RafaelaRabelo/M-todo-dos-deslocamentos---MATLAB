***************************************************************************

Programa para Análise de estruturas reticuladas em regime elástico

Autor: Rafaela Bernardes Rabelo
Última alteração: Setembro / 2020

***************************************************************************

Tipo de estrutura: Tipo de elemento: EP-RQ4

Número de nós:                        8
Número de materiais:                  1
Número de seções transversais:        1
Número de elementos:                  3
Número de apoios:                     2
Número de nós carregados:             2
Número de propriedades dos materiais: 3
Número de propriedades geometricas:   1
Número de nos dos elementos:          4
Número de elementos carregados:       1

Coordenadas dos nós:
  Nó       X          Y
  1        0.0        0.0
  2        0.0        0.4
  3        0.4        0.0
  4        0.4        0.4
  5        0.8        0.0
  6        0.8        0.4
  7        1.2        0.0
  8        1.2        0.4

Propriedades dos materiais:
 Mat         E                Poisson          alfa
  1      25000000.0             0.2             0.0

Propriedades das seções:
 Sec         t
  1         4.00

Propriedades dos elementos:
 El   Nó 1  Nó 2  Nó 3  Nó 4   Mat   Sec
  1     1     3     4     2     1     1
  2     3     5     6     4     1     1
  3     5     7     8     6     1     1

Condições de apoio:
 Ap    no    rtx   rty
  1     1     1     0
  2     2     1     1

Cargas nos elementos:
  Id   nó   sistema   qx_1     qy_1     qx_2     qy_2    qx_3     qy_3     qx_4     qy_4
  1     3    local    0.000    0.000    2.000    0.000    0.000    0.000    0.000    0.000

Cargas nos nós:
 Id    nó       Fx         Fy
  1     7      1.000      0.000
  2     8      1.000      0.000

Deslocamentos Nodais:
Nó      Ux         Uy
  1           0.0000e+00           1.2480e-08
  2           0.0000e+00           0.0000e+00
  3           4.9920e-08           1.2480e-08
  4           4.9920e-08          -7.2823e-23
  5           9.9840e-08           1.2480e-08
  6           9.9840e-08          -2.6391e-22
  7           1.4976e-07           1.2480e-08
  8           1.4976e-07          -5.3648e-22


Esforços solicitantes da estrutura:

--->> No elemento 1:
Deformações: 
        Epsilon x        Epsilon y        Gama xy
       1.24800e-07      -3.12000e-08      -2.48544e-23
Tensões: 
         Sigma x        Sigma y        Tau xy
       3.25000e+00             00000      -2.58900e-16

--->> No elemento 2:
Deformações: 
        Epsilon x        Epsilon y        Gama xy
       1.24800e-07      -3.12000e-08      -4.13201e-23
Tensões: 
         Sigma x        Sigma y        Tau xy
       3.25000e+00             00000      -4.30418e-16

--->> No elemento 3:
Deformações: 
        Epsilon x        Epsilon y        Gama xy
       1.24800e-07      -3.12000e-08       3.87166e-23
Tensões: 
         Sigma x        Sigma y        Tau xy
       3.25000e+00      -1.11022e-16       4.03298e-16
