function [Pd_z ,Pw_z, Pz, Lt] = plsaFit3(V,Z,iter)

nd = size(V, 1);
nw = size(V, 2);
Lt = [];

% 3.Randomly initialization and allocation
% ========================================

% P(z), uniform prior distribution
Pz = repmat(1/Z, Z, 1);

% Pd_z, randomness and normalization
Pd_z = rand(nd, Z);
Pd_z = Pd_z * diag(1./sum(Pd_z, 1));
% Pw_z, randomness and normalization
Pw_z = rand(nw, Z);
Pw_z = Pw_z * diag(1./sum(Pw_z, 1));

Pz_dw = zeros(Z, nd, nw);

% 4.Call EM algorithm to train model and learn parameter
% ======================================================
for i=1:iter
    fprintf('Current iteration:%d...\n', i);
    
    % E-step
    Pz_dw = plsaEstep(Pz,Pd_z, Pw_z, Pz_dw);

    % M-step
    [Pz, Pd_z, Pw_z] =  plsaMstep(V, Pd_z,Pw_z,Pz_dw, Z);

    % Likelihood
    le = plsaLogLikelihood2(V, nw, Pz, Pd_z, Pw_z );
    Lt = [Lt le];
    fprintf('Likelihood: %f...\n', le);
end



