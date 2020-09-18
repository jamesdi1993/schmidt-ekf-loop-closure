% Convert quaternion to a rotation matrix
% See Eq.77 in http://mars.cs.umn.edu/tr/reports/Trawny05b.pdf
% param q: quaternion expressed in a column vector. Should be normalized
% before applying rotation.
function R = quat2rot2(q)
    q_hat = skew(q(1:3));
    R = eye(3) - 2 * q(4) * q_hat + 2 * q_hat*q_hat;
end