***************************************************************************

Programa para An�lise de estruturas reticuladas em regime el�stico

Autor: Rafaela Bernardes Rabelo
�ltima altera��o: Setembro / 2020

***************************************************************************

Tipo de estrutura: Tipo de elemento: EP-RQ8

N�mero de n�s:                        18
N�mero de materiais:                  2
N�mero de se��es transversais:        1
N�mero de elementos:                  3
N�mero de apoios:                     3
N�mero de n�s carregados:             2
N�mero de propriedades dos materiais: 3
N�mero de propriedades geometricas:   1
N�mero de nos dos elementos:          8
N�mero de elementos carregados:       1

Coordenadas dos n�s:
  N�       X          Y
  1        0.0        0.0
  2        0.0        0.2
  3        0.0        0.4
  4        0.2        0.0
  5        0.2        0.4
  6        0.4        0.0
  7        0.4        0.2
  8        0.4        0.4
  9        0.6        0.0
 10        0.6        0.4
 11        0.8        0.0
 12        0.8        0.2
 13        0.8        0.4
 14        1.0        0.0
 15        1.0        0.4
 16        1.2        0.0
 17        1.2        0.2
 18        1.2        0.4

Propriedades dos materiais:
 Mat         E                Poisson          alfa
  1      25000000.0             0.2             0.0
  2      21000000.0             0.1             0.0

Propriedades das se��es:
 Sec         t
  1         4.00

Propriedades dos elementos:
 El   N� 1  N� 2  N� 3  N� 4  N� 5  N� 6  N� 7  N� 8   Mat   Sec
  1     1     6     8     3     4     7     5     2     1     1
  2     6    11    13     8     9    12    10     7     1     1
  3    11    16    18    13    14    17    15    12     2     1

Condi��es de apoio:
 Ap    no    rtx   rty
  1     1     1     0
  2     2     1     1
  3     3     1     0

Cargas nos elementos:
  Id   n�   sistema   qx_1     qy_1     qx_2     qy_2    qx_3     qy_3     qx_4     qy_4
  1     3    local    0.000    0.000    3.500    0.000    0.000    0.000    0.000    0.000

Cargas nos n�s:
 Id    n�       Fx         Fy
  1    15      0.333      0.000
  2    16      1.333      0.000

Deslocamentos Nodais:
N�      Ux         Uy
  1           0.0000e+00           8.6901e-09
  2           0.0000e+00           0.0000e+00
  3           0.0000e+00          -5.7133e-09
  4           5.1524e-08           1.6187e-08
  5           2.1525e-08           1.8121e-09
  6           1.0308e-07           3.8929e-08
  7           7.2432e-08           2.9989e-08
  8           4.3065e-08           2.4098e-08
  9           1.5313e-07           7.6730e-08
 10           6.3126e-08           6.1229e-08
 11           2.0302e-07           1.2745e-07
 12           1.4652e-07           1.2003e-07
 13           8.3069e-08           1.1541e-07
 14           2.7312e-07           1.9393e-07
 15           1.1556e-07           1.8727e-07
 16           3.4673e-07           2.9857e-07
 17           2.2223e-07           2.7882e-07
 18           1.4341e-07           2.6265e-07


Esfor�os solicitantes da estrutura:

--->> No elemento 1:
Deforma��es: 
        Epsilon x        Epsilon y        Gama xy
       1.81080e-07      -3.59372e-08      -2.48004e-11
Tens�es: 
         Sigma x        Sigma y        Tau xy
       4.52845e+00       7.25939e-03      -2.58337e-04

--->> No elemento 2:
Deforma��es: 
        Epsilon x        Epsilon y        Gama xy
       1.85216e-07      -3.87543e-08       8.11212e-11
Tens�es: 
         Sigma x        Sigma y        Tau xy
       4.62149e+00      -4.45584e-02       8.45012e-04

--->> No elemento 3:
Deforma��es: 
        Epsilon x        Epsilon y        Gama xy
       1.89272e-07      -1.66481e-08       3.07469e-09
Tens�es: 
         Sigma x        Sigma y        Tau xy
       4.01255e+00       2.52274e-01       2.80733e-02
