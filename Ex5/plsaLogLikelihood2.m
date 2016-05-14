function ll = plsaLogLikelihood2(V, nw,Pz, Pd_z, Pw_z )
ll = 0.0;
for i=1:nw
    ll = ll + V(:,i)'*log(Pd_z*diag(Pz)*Pw_z(i,:)'+1);
end