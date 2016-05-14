function ids = query(Pz_q, Pz_d, k)

for d = 1:length(Pz_d)
    L(d) =  sum(abs(Pz_q- Pz_d(:,d)));
end

[~, idx]  = sort(L);
ids = idx(1:k);


end