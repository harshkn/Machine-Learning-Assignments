%PLSA_ESTEP calcuate P(z|d,w) in expection step.
function Pz_dw = plsaEstep(Pz,Pd_z, Pw_z, Pz_dw)


% topics
K = length(Pz);
for i=1:K,
    Pz_dw(i,:,:) = Pd_z(:,i)*Pw_z(:,i)'*Pz(i);
end

% summarization for topic dimension
C = sum(Pz_dw, 1);

for i=1:K,
    Pz_dw(i,:,:) = Pz_dw(i,:,:)./C;
end