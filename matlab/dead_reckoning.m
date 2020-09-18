function p = dead_reckoning(base_dir, imu_meas, s0)
    %% Read measurement data
    imu_path = fullfile(base_dir, imu_meas);
    data = readmatrix(imu_path); 

    %% Prediction
    states = zeros(size(data,1), 16);
    s = s0;
    states(1, :) = s'; % save initial state;

    for i = 1:size(data,1)-1
        dt = data(i+1, 1) - data(i, 1);
        a = data(i, 2:4)';
        w = data(i, 5:7)';
        s = predict_mean_discrete(s, a, w, dt); % 16 x 1
        states(i+1, :) = s';
    end

    p = states(:, 5:7); % extract only the translational components;
end