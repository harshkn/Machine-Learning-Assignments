function [ sumres ] = findimpairsum(imknown, imrestored )
prod = imknown .* imrestored;
sumres = sum(prod(:));
end
