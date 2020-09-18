close all; clear
%% Read measurement data
base_dir = "/home/jamesdi1993/workspace/catkin_imu/src/IMUsimulation/ov_data/sim/";
imu_meas = "imumeas.csv";

imu_path = fullfile(base_dir, imu_meas);
data = readmatrix(imu_path); 

%% Assume zero-bias for debugging
ba0 = [0, 0, 0];
bg0 = [0, 0, 0];

%% Initial state
q0 = [0.7497, -0.2141, -0.1667, 0.6036]; % qx, qy, qz, qw, JPL format
p0 = [0.2620, -1.1057, 0.1599];
v0 = [-0.2493, -1.1452, 0.0836];

%% Prediction
states = zeros(size(data,1), 16);
s = [q0, p0, v0, bg0, ba0]';
states(1, :) = s'; % save initial state;

for i = 2:size(data,1)
    a = data(i, 2:4)';
    w = data(i, 5:7)';
    dt = data(i, 1) - data(i-1, 1);
    s = predict_mean_discrete(s, a, w, dt); % 16 x 1, [q, p, v, bg, ba]
    states(i, :) = s';
end

p = states(:, 5:7);

%% Plot
n = 10000;
ax1 = plot(p(1:n, 1), p(1:n, 2), 'DisplayName', 'Discrete Prediction');
legend();