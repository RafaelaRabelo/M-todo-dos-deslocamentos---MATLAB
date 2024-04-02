%**************************************************************************
%Programa para an�lise linear de estruturas reticuladas em regime elast.
%linear usando M.E.F. (ALERMEF)
%Autora: RAFAELA BERNARDES RABELO
%Vers�o de: 28/12/2020
%**************************************************************************

function [Kel] = ALERMEF_EP_RQ8_MatrizDeRigidezDoElemento(E,nu,t,tipoestr,...
    a,b)
Kel = zeros(16,16);
    if strcmp(tipoestr,'EPD')
        E=E/(1-nu^2);
        nu= nu/(1-nu);
    end
Kel =[0.13e2 / 0.45e2 * E / a / b * (a ^ 2 * nu - a ^ 2 - 2 * b ^ 2) / (nu ^ 2 - 1) -0.17e2 / 0.72e2 * E / (-1 + nu) (E / a / b * (17 * a ^ 2 * nu - 17 * a ^ 2 - 56 * b ^ 2) / (nu ^ 2 - 1)) / 0.180e3 (E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 0.23e2 / 0.180e3 * E / a / b * (a ^ 2 * nu - a ^ 2 - 2 * b ^ 2) / (nu ^ 2 - 1) -0.7e1 / 0.72e2 * E / (-1 + nu) (E / a / b * (14 * a ^ 2 * nu - 14 * a ^ 2 - 17 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 -(E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 (E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 + 80 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 -(E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 -(1 / b * E * (10 * a ^ 2 * nu - 10 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 (E / (-1 + nu)) / 0.18e2 -(E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 - 40 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 (E / (-1 + nu)) / 0.18e2 -(1 / b * E * (20 * a ^ 2 * nu - 20 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 (E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2; -0.17e2 / 0.72e2 * E / (-1 + nu) -0.13e2 / 0.45e2 * E / a / b * (-b ^ 2 * nu + 2 * a ^ 2 + b ^ 2) / (nu ^ 2 - 1) -(E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 -(E / a / b * (-14 * b ^ 2 * nu + 17 * a ^ 2 + 14 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 -0.7e1 / 0.72e2 * E / (-1 + nu) -0.23e2 / 0.180e3 * E / a / b * (-b ^ 2 * nu + 2 * a ^ 2 + b ^ 2) / (nu ^ 2 - 1) (E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 -(E / a / b * (-17 * b ^ 2 * nu + 56 * a ^ 2 + 17 * b ^ 2) / (nu ^ 2 - 1)) / 0.180e3 (E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 -(E / a / b * (20 * b ^ 2 * nu + 3 * a ^ 2 - 20 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 (E / (-1 + nu)) / 0.18e2 (1 / b * E * (-3 * b ^ 2 * nu + 40 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2 (E / (-1 + nu)) / 0.18e2 (E / a / b * (-10 * b ^ 2 * nu + 3 * a ^ 2 + 10 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 -(E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 (1 / b * E * (3 * b ^ 2 * nu + 80 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2; (E / a / b * (17 * a ^ 2 * nu - 17 * a ^ 2 - 56 * b ^ 2) / (nu ^ 2 - 1)) / 0.180e3 -(E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 0.13e2 / 0.45e2 * E / a / b * (a ^ 2 * nu - a ^ 2 - 2 * b ^ 2) / (nu ^ 2 - 1) 0.17e2 / 0.72e2 * E / (-1 + nu) (E / a / b * (14 * a ^ 2 * nu - 14 * a ^ 2 - 17 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 (E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 0.23e2 / 0.180e3 * E / a / b * (a ^ 2 * nu - a ^ 2 - 2 * b ^ 2) / (nu ^ 2 - 1) 0.7e1 / 0.72e2 * E / (-1 + nu) (E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 + 80 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 (E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 -(1 / b * E * (20 * a ^ 2 * nu - 20 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 -(E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 -(E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 - 40 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 -(E / (-1 + nu)) / 0.18e2 -(1 / b * E * (10 * a ^ 2 * nu - 10 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 -(E / (-1 + nu)) / 0.18e2; (E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 -(E / a / b * (-14 * b ^ 2 * nu + 17 * a ^ 2 + 14 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 0.17e2 / 0.72e2 * E / (-1 + nu) -0.13e2 / 0.45e2 * E / a / b * (-b ^ 2 * nu + 2 * a ^ 2 + b ^ 2) / (nu ^ 2 - 1) -(E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 -(E / a / b * (-17 * b ^ 2 * nu + 56 * a ^ 2 + 17 * b ^ 2) / (nu ^ 2 - 1)) / 0.180e3 0.7e1 / 0.72e2 * E / (-1 + nu) -0.23e2 / 0.180e3 * E / a / b * (-b ^ 2 * nu + 2 * a ^ 2 + b ^ 2) / (nu ^ 2 - 1) -(E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 -(E / a / b * (20 * b ^ 2 * nu + 3 * a ^ 2 - 20 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 (E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 (1 / b * E * (3 * b ^ 2 * nu + 80 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2 -(E / (-1 + nu)) / 0.18e2 (E / a / b * (-10 * b ^ 2 * nu + 3 * a ^ 2 + 10 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 -(E / (-1 + nu)) / 0.18e2 (1 / b * E * (-3 * b ^ 2 * nu + 40 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2; 0.23e2 / 0.180e3 * E / a / b * (a ^ 2 * nu - a ^ 2 - 2 * b ^ 2) / (nu ^ 2 - 1) -0.7e1 / 0.72e2 * E / (-1 + nu) (E / a / b * (14 * a ^ 2 * nu - 14 * a ^ 2 - 17 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 -(E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 0.13e2 / 0.45e2 * E / a / b * (a ^ 2 * nu - a ^ 2 - 2 * b ^ 2) / (nu ^ 2 - 1) -0.17e2 / 0.72e2 * E / (-1 + nu) (E / a / b * (17 * a ^ 2 * nu - 17 * a ^ 2 - 56 * b ^ 2) / (nu ^ 2 - 1)) / 0.180e3 (E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 -(E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 - 40 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 (E / (-1 + nu)) / 0.18e2 -(1 / b * E * (20 * a ^ 2 * nu - 20 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 (E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 (E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 + 80 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 -(E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 -(1 / b * E * (10 * a ^ 2 * nu - 10 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 (E / (-1 + nu)) / 0.18e2; -0.7e1 / 0.72e2 * E / (-1 + nu) -0.23e2 / 0.180e3 * E / a / b * (-b ^ 2 * nu + 2 * a ^ 2 + b ^ 2) / (nu ^ 2 - 1) (E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 -(E / a / b * (-17 * b ^ 2 * nu + 56 * a ^ 2 + 17 * b ^ 2) / (nu ^ 2 - 1)) / 0.180e3 -0.17e2 / 0.72e2 * E / (-1 + nu) -0.13e2 / 0.45e2 * E / a / b * (-b ^ 2 * nu + 2 * a ^ 2 + b ^ 2) / (nu ^ 2 - 1) -(E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 -(E / a / b * (-14 * b ^ 2 * nu + 17 * a ^ 2 + 14 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 (E / (-1 + nu)) / 0.18e2 (E / a / b * (-10 * b ^ 2 * nu + 3 * a ^ 2 + 10 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 -(E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 (1 / b * E * (3 * b ^ 2 * nu + 80 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2 (E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 -(E / a / b * (20 * b ^ 2 * nu + 3 * a ^ 2 - 20 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 (E / (-1 + nu)) / 0.18e2 (1 / b * E * (-3 * b ^ 2 * nu + 40 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2; (E / a / b * (14 * a ^ 2 * nu - 14 * a ^ 2 - 17 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 (E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 0.23e2 / 0.180e3 * E / a / b * (a ^ 2 * nu - a ^ 2 - 2 * b ^ 2) / (nu ^ 2 - 1) 0.7e1 / 0.72e2 * E / (-1 + nu) (E / a / b * (17 * a ^ 2 * nu - 17 * a ^ 2 - 56 * b ^ 2) / (nu ^ 2 - 1)) / 0.180e3 -(E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 0.13e2 / 0.45e2 * E / a / b * (a ^ 2 * nu - a ^ 2 - 2 * b ^ 2) / (nu ^ 2 - 1) 0.17e2 / 0.72e2 * E / (-1 + nu) -(E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 - 40 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 -(E / (-1 + nu)) / 0.18e2 -(1 / b * E * (10 * a ^ 2 * nu - 10 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 -(E / (-1 + nu)) / 0.18e2 (E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 + 80 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 (E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 -(1 / b * E * (20 * a ^ 2 * nu - 20 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 -(E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2; -(E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 -(E / a / b * (-17 * b ^ 2 * nu + 56 * a ^ 2 + 17 * b ^ 2) / (nu ^ 2 - 1)) / 0.180e3 0.7e1 / 0.72e2 * E / (-1 + nu) -0.23e2 / 0.180e3 * E / a / b * (-b ^ 2 * nu + 2 * a ^ 2 + b ^ 2) / (nu ^ 2 - 1) (E * (3 * nu - 1) / (nu ^ 2 - 1)) / 0.24e2 -(E / a / b * (-14 * b ^ 2 * nu + 17 * a ^ 2 + 14 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 0.17e2 / 0.72e2 * E / (-1 + nu) -0.13e2 / 0.45e2 * E / a / b * (-b ^ 2 * nu + 2 * a ^ 2 + b ^ 2) / (nu ^ 2 - 1) -(E / (-1 + nu)) / 0.18e2 (E / a / b * (-10 * b ^ 2 * nu + 3 * a ^ 2 + 10 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 -(E / (-1 + nu)) / 0.18e2 (1 / b * E * (-3 * b ^ 2 * nu + 40 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2 -(E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 -(E / a / b * (20 * b ^ 2 * nu + 3 * a ^ 2 - 20 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 (E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 (1 / b * E * (3 * b ^ 2 * nu + 80 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2; (E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 + 80 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 (E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 (E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 + 80 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 -(E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 -(E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 - 40 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 (E / (-1 + nu)) / 0.18e2 -(E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 - 40 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 -(E / (-1 + nu)) / 0.18e2 0.4e1 / 0.45e2 * E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 - 20 * b ^ 2) / (nu ^ 2 - 1) 0 0 0.2e1 / 0.9e1 * E / (-1 + nu) -0.4e1 / 0.45e2 * E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 + 10 * b ^ 2) / (nu ^ 2 - 1) 0 0 -0.2e1 / 0.9e1 * E / (-1 + nu); -(E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 -(E / a / b * (20 * b ^ 2 * nu + 3 * a ^ 2 - 20 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 (E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 -(E / a / b * (20 * b ^ 2 * nu + 3 * a ^ 2 - 20 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 (E / (-1 + nu)) / 0.18e2 (E / a / b * (-10 * b ^ 2 * nu + 3 * a ^ 2 + 10 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 -(E / (-1 + nu)) / 0.18e2 (E / a / b * (-10 * b ^ 2 * nu + 3 * a ^ 2 + 10 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 0 -0.8e1 / 0.45e2 * E / a / b * (-5 * b ^ 2 * nu + 3 * a ^ 2 + 5 * b ^ 2) / (nu ^ 2 - 1) 0.2e1 / 0.9e1 * E / (-1 + nu) 0 0 0.4e1 / 0.45e2 * E / a / b * (5 * b ^ 2 * nu + 6 * a ^ 2 - 5 * b ^ 2) / (nu ^ 2 - 1) -0.2e1 / 0.9e1 * E / (-1 + nu) 0; -(1 / b * E * (10 * a ^ 2 * nu - 10 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 (E / (-1 + nu)) / 0.18e2 -(1 / b * E * (20 * a ^ 2 * nu - 20 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 (E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 -(1 / b * E * (20 * a ^ 2 * nu - 20 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 -(E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 -(1 / b * E * (10 * a ^ 2 * nu - 10 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 -(E / (-1 + nu)) / 0.18e2 0 0.2e1 / 0.9e1 * E / (-1 + nu) 0.8e1 / 0.45e2 / b * E * (5 * a ^ 2 * nu - 5 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a 0 0 -0.2e1 / 0.9e1 * E / (-1 + nu) 0.4e1 / 0.45e2 / b * E * (5 * a ^ 2 * nu - 5 * a ^ 2 + 6 * b ^ 2) / (nu ^ 2 - 1) / a 0; (E / (-1 + nu)) / 0.18e2 (1 / b * E * (-3 * b ^ 2 * nu + 40 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2 -(E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 (1 / b * E * (3 * b ^ 2 * nu + 80 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2 (E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 (1 / b * E * (3 * b ^ 2 * nu + 80 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2 -(E / (-1 + nu)) / 0.18e2 (1 / b * E * (-3 * b ^ 2 * nu + 40 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2 0.2e1 / 0.9e1 * E / (-1 + nu) 0 0 -0.4e1 / 0.45e2 / b * E * (-3 * b ^ 2 * nu + 20 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a -0.2e1 / 0.9e1 * E / (-1 + nu) 0 0 -0.4e1 / 0.45e2 / b * E * (3 * b ^ 2 * nu + 10 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a; -(E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 - 40 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 (E / (-1 + nu)) / 0.18e2 -(E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 - 40 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 -(E / (-1 + nu)) / 0.18e2 (E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 + 80 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 (E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 (E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 + 80 * b ^ 2) / (nu ^ 2 - 1)) / 0.90e2 -(E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 -0.4e1 / 0.45e2 * E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 + 10 * b ^ 2) / (nu ^ 2 - 1) 0 0 -0.2e1 / 0.9e1 * E / (-1 + nu) 0.4e1 / 0.45e2 * E / a / b * (3 * a ^ 2 * nu - 3 * a ^ 2 - 20 * b ^ 2) / (nu ^ 2 - 1) 0 0 0.2e1 / 0.9e1 * E / (-1 + nu); (E / (-1 + nu)) / 0.18e2 (E / a / b * (-10 * b ^ 2 * nu + 3 * a ^ 2 + 10 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 -(E / (-1 + nu)) / 0.18e2 (E / a / b * (-10 * b ^ 2 * nu + 3 * a ^ 2 + 10 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 -(E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 -(E / a / b * (20 * b ^ 2 * nu + 3 * a ^ 2 - 20 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 (E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 -(E / a / b * (20 * b ^ 2 * nu + 3 * a ^ 2 - 20 * b ^ 2) / (nu ^ 2 - 1)) / 0.45e2 0 0.4e1 / 0.45e2 * E / a / b * (5 * b ^ 2 * nu + 6 * a ^ 2 - 5 * b ^ 2) / (nu ^ 2 - 1) -0.2e1 / 0.9e1 * E / (-1 + nu) 0 0 -0.8e1 / 0.45e2 * E / a / b * (-5 * b ^ 2 * nu + 3 * a ^ 2 + 5 * b ^ 2) / (nu ^ 2 - 1) 0.2e1 / 0.9e1 * E / (-1 + nu) 0; -(1 / b * E * (20 * a ^ 2 * nu - 20 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 -(E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 -(1 / b * E * (10 * a ^ 2 * nu - 10 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 -(E / (-1 + nu)) / 0.18e2 -(1 / b * E * (10 * a ^ 2 * nu - 10 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 (E / (-1 + nu)) / 0.18e2 -(1 / b * E * (20 * a ^ 2 * nu - 20 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.45e2 (E * (7 * nu - 5) / (nu ^ 2 - 1)) / 0.18e2 0 -0.2e1 / 0.9e1 * E / (-1 + nu) 0.4e1 / 0.45e2 / b * E * (5 * a ^ 2 * nu - 5 * a ^ 2 + 6 * b ^ 2) / (nu ^ 2 - 1) / a 0 0 0.2e1 / 0.9e1 * E / (-1 + nu) 0.8e1 / 0.45e2 / b * E * (5 * a ^ 2 * nu - 5 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a 0; (E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 (1 / b * E * (3 * b ^ 2 * nu + 80 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2 -(E / (-1 + nu)) / 0.18e2 (1 / b * E * (-3 * b ^ 2 * nu + 40 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2 (E / (-1 + nu)) / 0.18e2 (1 / b * E * (-3 * b ^ 2 * nu + 40 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2 -(E * (11 * nu - 1) / (nu ^ 2 - 1)) / 0.18e2 (1 / b * E * (3 * b ^ 2 * nu + 80 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a) / 0.90e2 -0.2e1 / 0.9e1 * E / (-1 + nu) 0 0 -0.4e1 / 0.45e2 / b * E * (3 * b ^ 2 * nu + 10 * a ^ 2 - 3 * b ^ 2) / (nu ^ 2 - 1) / a 0.2e1 / 0.9e1 * E / (-1 + nu) 0 0 -0.4e1 / 0.45e2 / b * E * (-3 * b ^ 2 * nu + 20 * a ^ 2 + 3 * b ^ 2) / (nu ^ 2 - 1) / a];
Kel=t*Kel;
end

