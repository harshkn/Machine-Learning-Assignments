%PLSA_MSTEP calculate P(z), P(d|z) and P(w|z) given n(d,w) and
%  P(z|d, w).

function [Pz, Pd_z, Pw_z] =  plsaMstep(V, Pd_z,Pw_z,Pz_dw, Z)



% P(d|z), P(w|z) numerator 
for i=1:Z
    Pd_z(:,i) = sum(V.*reshape(Pz_dw(i,:,:), size(V)), 2);
    Pw_z(:,i) = sum(V.*reshape(Pz_dw(i,:,:),size(V)),  1);
end

% P(z)
Pz = sum(Pw_z, 1);
Pz = Pz ./ sum(Pz);

% P(d|z, P(w|z)
C = sum(Pd_z, 1);
Pd_z = Pd_z * diag(1./C);

C = sum(Pw_z, 1);
Pw_z = Pw_z * diag(1./C);