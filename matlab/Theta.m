function [X] = Theta(dt, w)
    w_norm = norm(w);
    % if w is really small, putting w in the denominator will cause
    % instability issue
    if w_norm < 1e-20
        X = eye(4) + 0.5 * dt * Omega(w);
    else
        X = cos(0.5 * w_norm * dt) * eye(4) + 1/w_norm * sin(0.5 * w_norm * dt) * Omega(w);
    end
end