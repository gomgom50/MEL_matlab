% %% E2016 Opg 1: Dronens landingspræcision
clear all; close all; clc;

mu = 0.45
lambda = 1/mu

%% a
p_under1m = expcdf(1,mu)

%% b
p_mellem1og2m = expcdf(2,mu) - expcdf(1,mu)

%% c
p_over2m = 1 - expcdf(2,mu)

