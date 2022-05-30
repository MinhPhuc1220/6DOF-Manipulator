function out = Chrstffel(M,the,i,j,k)
% Chrstffel are Christoffel Fomulas
% Mjk is component of Mass Matrix.
% i is numberism of Degree of Freedom.
% j, k is position of Mass Matrix.

out = diff(M(i,j),the(k)) + diff(M(i,k),the(j)) - diff(M(j,k),the(i));