function L = getLDistance(Pz_q, Pz_d, Z, nd)
for d = 1:nd
    L(d) =  sum(abs(Pz_q- Pz_d(:,d)));
end
end