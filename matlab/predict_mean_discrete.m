% Predict the state at next timestamp using discrete propagation
% See https://docs.openvins.com/propagation.html#disc_prop
function sn = predict_mean_discrete(s, a, w, dt)
    g = [0, 0, 9.80766]';
    q = s(1:4);
    q = normalize_quat(q);
    
    p = s(5:7);
    v = s(8:10);
    bg = s(11:13);
    ba = s(14:16);
    
    % pre-compute things
    % R = quat2rot2(q);
    R = quat2rot(q);
    a_hat = a - ba;
    w_hat = w - bg;
    dt2 = dt^2;
    
    % predict next state
    qn = Theta(dt, w_hat) * q;
    vn = v - dt * g + dt * R' * a_hat;
    pn = p + dt * v - 0.5 * g * dt2 + 0.5 * R' * a_hat * dt2;
    bgn = bg;
    bga = ba;
    sn = [qn', pn', vn', bgn', bga']';
end