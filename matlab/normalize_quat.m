function q = normalize_quat(q)
    q = q / norm(q);
    if q(4) < 0
        q = -q;
    end
end