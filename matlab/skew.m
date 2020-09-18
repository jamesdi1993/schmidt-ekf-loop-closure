% Skew symmetric matrix of a vector.
% See Eq.6 in http://mars.cs.umn.edu/tr/reports/Trawny05b.pdf
function w_hat = skew(w)
    w_hat = [   0, -w(3),  w(2); 
             w(3),     0, -w(1); 
            -w(2),  w(1),     0];
end