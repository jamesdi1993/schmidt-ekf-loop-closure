% Matrix Omega for product of a vector and quaternion
% See Eq.47 in http://mars.cs.umn.edu/tr/reports/Trawny05b.pdf
function X = Omega(w)
    X = zeros(4, 4);
    X(1:3, 1:3) = -skew(w);
    X(1:3, 4) = w;
    X(4, 1:3) = -w;
end
