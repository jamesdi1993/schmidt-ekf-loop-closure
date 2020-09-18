close all; clear;

%% File paths
base_dir = "/home/jamesdi1993/workspace/catkin_imu/src/IMUsimulation/ov_data/sim/";
openvins_file = "imupose.csv";
gt_file = "udel_gore.txt";
imu_meas = "imumeas.csv";

% Read from the Groundtruth
gt_path = fullfile(base_dir, gt_file);
gt_traj = readmatrix(gt_path, 'Filetype', 'text', 'Delimiter', ' ', 'ExpectedNumVariables', 14); 

% Read from OpenVINS dead-reckoning
openvins_path = fullfile(base_dir, openvins_file);
openvins_traj = readmatrix(openvins_path);

%% Initial state
q0 = [0.7497, -0.2141, -0.1667, 0.6036]; % qx, qy, qz, qw, JPL format
p0 = [0.2620, -1.1057, 0.1599];
v0 = [-0.2493, -1.1452, 0.0836];

% Assume zero-bias for debugging
ba0 = [0, 0, 0];
bg0 = [0, 0, 0];
s0 = [q0, p0, v0, bg0, ba0]';

% Perform deadreckoning
dr_traj = dead_reckoning(base_dir, imu_meas, s0);

%% Plot 
figure();
ax1 = plot(gt_traj(:, 2), gt_traj(:, 3), 'DisplayName', 'GroundTruth');
hold on;
ax2 = plot(openvins_traj(:, 2), openvins_traj(:, 3), 'DisplayName', 'OpenVINS-deadreckon');
hold on;

% Plot the first n sequences
% n = 15000;
n = size(dr_traj, 1);
ax3 = plot(dr_traj(1:n, 1), dr_traj(1:n, 2), 'DisplayName', 'deadreckon-discrete');
xlabel('X'); ylabel('Y');
title("Dead-Reckoning");
legend();
   