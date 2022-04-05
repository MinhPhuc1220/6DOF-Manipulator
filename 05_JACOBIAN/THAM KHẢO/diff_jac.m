function out = diff_jac(w,the_d)

out = simplify(diff([w(1); w(2); w(3)],the_d));