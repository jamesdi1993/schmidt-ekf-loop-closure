% Convert quaternion to a rotation matrix
% See Eq.62 in http://mars.cs.umn.edu/tr/reports/Trawny05b.pdf
% param q: quaternion expressed in a column vector. Should be normalized
% before applying rotation.
function R = quat2rot(q)
    qs = q(1:3);
    R = (2 * (q(4)^2) - 1) * eye(3) - 2 * q(4) * skew(qs) + 2 * (qs * qs');
end